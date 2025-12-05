package com.test.mybatis.controller.group;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.mybatis.dao.IChallengeDAO;
import com.test.mybatis.dao.IGroupPostDAO;
import com.test.mybatis.dto.ChallengeContentDTO;
import com.test.mybatis.dto.ChallengeInfoDTO;
import com.test.mybatis.dto.ChallengerDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class ChallengeController
{

	@Autowired
	private SqlSession sqlSession;

	// 도전과제 리스트 출력
	@RequestMapping(value = "/challengelist.do")
	public String getChallengeList(Model model, HttpSession session, HttpServletRequest request)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);

		// 세션의 UserDTO + 받아온 groupApply를 통해 뽑기
		try
		{
			// 이전 페이지로(group/home.jsp, common/GroupSideBar.jsp, ...)부터 받는 groupApplyCode
			String groupApplyCode = request.getParameter("groupApplyCode");
			/*
			// 세션에서 받은 UserDTO
			UserDTO user = (UserDTO) session.getAttribute("user");
			
			// 회원이 아닐 때
			if (user == null)
			{
				String msg = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
				return "redirect:errorpage.do?error=" + msg + "&url=loginpage.do";
			}
			*/
			/*
			boolean flag = false;
			
			// groupApplyCode 랑 userCode 받기 가능
			// userCode를 가지고 groupApplyCode가 일치하는 모임이 있는지 확인
			for (String temp : dao.getGroupApplyCodes(user.getUserCode()))
			{
				if (groupApplyCode != null && groupApplyCode.equals(temp))
				{
					flag = true;
					break;
				}
			}
			*/
			/*
			// 모임원이 아니라면 메인페이지로
			if (!flag)
			{
				if (groupApplyCode == null)
					System.out.println("모임 번호 null");
				String msg = URLEncoder.encode("해당 모임의 회원이 아닙니다.", StandardCharsets.UTF_8.toString());
				return "redirect:errorpage.do?error=" + msg + "&url=/home.do?groupApplyCode=" + groupApplyCode;
			}
			*/
			// groupApplyCode로 리스트 출력
			ArrayList<ChallengeInfoDTO> challengeList = dao.challengeList(groupApplyCode);

			// 가져온 속성
			// → challengeCode, joinCode, challengeType, title, startDate, content, createdDate
			// 필요한 속성
			// → endDate, status + nickname

			// 필요 속성 구하기
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			for (ChallengeInfoDTO dto : challengeList)
			{
				// 종료 날짜 구하기
				LocalDate startDate = LocalDate.parse(dto.getStartDate(), formatter);
				LocalDate endDate = null;

				if ("1".equals(dto.getChallengeType())) // 주간 과제
					endDate = startDate.plusDays(7);
				else if ("2".equals(dto.getChallengeType())) // 월간 과제
					endDate = startDate.plusDays(35);

				dto.setEndDate(endDate.format(formatter));

				// 진행상태 구하기
				// 1 → 대기, 2 → 진행중, 3 → 종료
				LocalDate currentDate = LocalDate.now();
				if (currentDate.isBefore(startDate))
					dto.setStatus("1");
				else if (currentDate.isBefore(endDate))
					dto.setStatus("2");
				else
					dto.setStatus("3");

				// 닉네임 구하기
				dto.setNickname(dao.getNickname(dto.getJoinCode()));
			}

			model.addAttribute("challengeList", challengeList);

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return "/WEB-INF/view/group_room/challenge/ChallengeList.jsp";
	}

	// 도전과제 등록 페이지 출력
	@RequestMapping(value = "/challengecreatepage.do")
	public String createChallengePage(HttpSession session, HttpServletRequest request) throws UnsupportedEncodingException
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);

		String groupApplyCode = request.getParameter("groupApplyCode");
		
		UserDTO user = (UserDTO)session.getAttribute("user");
		if (user == null)
		{
			String msg = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
			return "redirect:errorpage.do?error=" + msg + "&url=loginpage.do";
		}
		
		boolean flag = false;
		// groupApplyCode 랑 userCode 받기 가능
		// userCode를 가지고 groupApplyCode가 일치하는 모임이 있는지 확인
		for (String temp : dao.getGroupApplyCodes(user.getUserCode()))
		{
			if (groupApplyCode != null && groupApplyCode.equals(temp))
			{
				flag = true;
				break;
			}
		}
		
		// 모임원이 아니라면 메인페이지로
		if (!flag)
		{
			if (groupApplyCode == null)
				System.out.println("모임 번호 null");
			String msg = URLEncoder.encode("해당 모임의 회원이 아닙니다.", StandardCharsets.UTF_8.toString());
			return "redirect:errorpage.do?error=" + msg + "&url=/home.do?groupApplyCode=" + groupApplyCode;
		}
		
		return "/WEB-INF/view/group_room/challenge/ChallengeCreate.jsp";
	}

	// 도전과제 등록 프로세스
	@RequestMapping(value = "/challengecreate.do", method = RequestMethod.POST)
	public String createChallenge(HttpSession session, HttpServletRequest request, ChallengeInfoDTO challengeDto)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);

		// 이전 페이지(→ ChallengeList.jsp)에서 전달한 데이터
		// groupApplyCode
		String groupApplyCode = request.getParameter("groupApplyCode");

		// session의 user
		UserDTO user = (UserDTO) session.getAttribute("user");
		// groupApplyCode, user를 활용해 joinCode 확인
		String joinCode = "";
		joinCode = dao.getJoinCodeFromUCGA(user.getUserCode(), groupApplyCode);

		// 받아온 challengeDto
		// → title, startDate, Content, ChallengeType
		// Type에 맞는 회차 내용 (day1, day2, ... )

		// 도전과제 세부 내용 입력용 DTO 생성 및 데이터 이전
		ChallengeContentDTO contentDto = new ChallengeContentDTO();

		contentDto.setJoinCode(joinCode);
		contentDto.setTitle(challengeDto.getTitle());
		contentDto.setContent(challengeDto.getContent());
		contentDto.setChallengeType(challengeDto.getChallengeType());
		contentDto.setStartDate(challengeDto.getStartDate());

		// challengeType (1 → daily, 2 → weekly)
		if ("daily".equals(contentDto.getChallengeType()))
		{
			contentDto.setChallengeType("1");
			contentDto.setDay1(request.getParameter("day1"));
			contentDto.setDay2(request.getParameter("day2"));
			contentDto.setDay3(request.getParameter("day3"));
			contentDto.setDay4(request.getParameter("day4"));
			contentDto.setDay5(request.getParameter("day5"));
			contentDto.setDay6(request.getParameter("day6"));
			contentDto.setDay7(request.getParameter("day7"));
		} else
		{
			contentDto.setChallengeType("2");
			contentDto.setWeek1(request.getParameter("week1"));
			contentDto.setWeek2(request.getParameter("week2"));
			contentDto.setWeek3(request.getParameter("week3"));
			contentDto.setWeek4(request.getParameter("week4"));
			contentDto.setWeek5(request.getParameter("week5"));
		}

		dao.challengeCreate(contentDto);

		return "redirect:/challengelist.do?groupApplyCode=" + groupApplyCode;
	}

	// 도전과제 상세 내용 출력
	@RequestMapping(value = "/challengedetailpage.do")
	public String challengeDetailPage(HttpSession session, HttpServletRequest request, Model model)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);
		try
		{
			// 이전 페이지에서 받는 정보
			// 세션에서 유저, challengeCode
			UserDTO user = (UserDTO) session.getAttribute("user");
			String challengeCode = request.getParameter("challengeCode");

			/*
			// 회원이 아닐 때
			if (user == null)
			{
				String msg = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
				return "redirect:errorpage.do?error=" + msg + "&url=loginpage.do";
			}
			*/
			// challengeCode가 null인지 확인
			if (challengeCode == null || challengeCode.trim().isEmpty())
			{
				String msg = URLEncoder.encode("도전과제 코드가 없습니다.", StandardCharsets.UTF_8.toString());
				return "redirect:errorpage.do?error=" + msg + "&url=/challengelist.do";
			}
			
			System.out.println("challengeCode: " + challengeCode);

			// 도전과제 정보 출력
			// (도전과제코드, 작성자, 제목, 내용, 유형, 시작일, 작성일)
			ChallengeInfoDTO challengeDetail = dao.getChallengeDetail(challengeCode);
			System.out.println("challengeDetail: " + challengeDetail);
			if (challengeDetail == null)
			{
				String msg = URLEncoder.encode("도전과제 정보를 찾을 수 없습니다.", StandardCharsets.UTF_8.toString());
				return "redirect:errorpage.do?error=" + msg + "&url=/challengelist.do";
			}
			System.out.println("challengeDetail.title: " + challengeDetail.getTitle());

			// 종료 날짜 구하기
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			if (challengeDetail.getStartDate() != null)
			{
				LocalDate startDate = LocalDate.parse(challengeDetail.getStartDate(), formatter);
				LocalDate endDate = null;

				if ("1".equals(challengeDetail.getChallengeType())) // 주간 과제
					endDate = startDate.plusDays(7);
				else if ("2".equals(challengeDetail.getChallengeType())) // 월간 과제
					endDate = startDate.plusDays(35);

				if (endDate != null)
					challengeDetail.setEndDate(endDate.format(formatter));
			}

			// 도전과제 내용 출력
			// (회차, 내용, 식별코드(challengeDetailCode))
			ArrayList<ChallengeContentDTO> challengeContentList = dao.getChallengeContent(challengeCode);
			if (challengeContentList == null)
				challengeContentList = new ArrayList<ChallengeContentDTO>();

			/*
			 * <p>참가자 : 8 명</p> <p>달성자 : 5 명</p> <p>달성률 : 62.5 %</p>
			 */
			
			// 도전과제 참가자 정보
			// ArrayList(joinCode, 달성수, 달성여부, 닉네임, 성공일)
			ArrayList<ChallengerDTO> members = dao.getChallengerInfo(challengeCode);	// joinCode, 달성수, 달성여부
			if (members == null)
				members = new ArrayList<ChallengerDTO>();
			for (ChallengerDTO member : members)
			{
				member.setNickname(dao.getNickname(member.getJoinCode()));
				if ("달성".equals(member.getSuccessed()))
					member.setSuccessedDate(dao.getSuccessDate(member.getJoinCode(), challengeCode));
			}

			// 현재 사용자의 joinCode 조회 (도전과제의 groupApplyCode로부터)
			String groupApplyCode = dao.getGroupApplyCodeByChallengeCode(challengeCode);
			String currentUserJoinCode = null;
			boolean isAuthor = false;
			boolean isParticipated = false;
			String challengeMemberCode = null;
			LocalDate endDate = null;
			boolean canEditChecklist = false;

			if (groupApplyCode != null)
			{
				IGroupPostDAO groupDao = sqlSession.getMapper(IGroupPostDAO.class);
				currentUserJoinCode = groupDao.getJoinCode(groupApplyCode, user.getUserCode());
				
				// 작성자 여부 확인
				if (currentUserJoinCode != null && currentUserJoinCode.equals(challengeDetail.getJoinCode()))
					isAuthor = true;
				
				// 참가 여부 확인
				if (currentUserJoinCode != null)
				{
					challengeMemberCode = dao.getChallengeMemberCode(challengeCode, currentUserJoinCode);
					if (challengeMemberCode != null)
						isParticipated = true;
				}
			}
			System.out.println(groupApplyCode);

			// 종료일 계산 및 체크리스트 수정 가능 여부 확인
			String checklistStatus = "not_started"; // not_started, available, expired
			if (challengeDetail.getStartDate() != null)
			{
				LocalDate startDate = LocalDate.parse(challengeDetail.getStartDate(), formatter);
				if ("1".equals(challengeDetail.getChallengeType()))
					endDate = startDate.plusDays(7);
				else if ("2".equals(challengeDetail.getChallengeType()))
					endDate = startDate.plusDays(35);
				
				// 체크리스트 수정 가능 여부: 시작일 이후 ~ 종료일 + 7일 이내
				if (endDate != null)
				{
					LocalDate currentDate = LocalDate.now();
					// 시작일 이전
					if (currentDate.isBefore(startDate))
					{
						checklistStatus = "not_started";
						canEditChecklist = false;
					}
					// 종료일 + 7일 이후
					else if (currentDate.isAfter(endDate.plusDays(7)))
					{
						checklistStatus = "expired";
						canEditChecklist = false;
					}
					// 시작일 이후 ~ 종료일 + 7일 이내
					else
					{
						checklistStatus = "available";
						canEditChecklist = true;
					}
				}
			}
			System.out.println(challengeDetail.getStartDate());

			// 현재 사용자의 체크리스트 체크 상태 확인
			ArrayList<String> checkedDetailCodes = new ArrayList<String>();
			if (challengeMemberCode != null)
			{
				checkedDetailCodes = dao.getCheckedDetailCodes(challengeMemberCode);
				if (checkedDetailCodes == null)
					checkedDetailCodes = new ArrayList<String>();
			}
			System.out.println(challengeMemberCode);
			
			model.addAttribute("checkedDetailCodes", checkedDetailCodes);

			model.addAttribute("challengeDetail", challengeDetail);
			model.addAttribute("challengeContentList", challengeContentList);
			model.addAttribute("members", members);
			model.addAttribute("isAuthor", isAuthor);
			model.addAttribute("isParticipated", isParticipated);
			model.addAttribute("canEditChecklist", canEditChecklist);
			model.addAttribute("challengeMemberCode", challengeMemberCode);
			model.addAttribute("endDate", endDate != null ? endDate.format(formatter) : null);
			model.addAttribute("groupApplyCode", groupApplyCode);
			model.addAttribute("checklistStatus", checklistStatus);
			
			return "/WEB-INF/view/group_room/challenge/ChallengeDetail.jsp";

		} catch (Exception e)
		{
			System.out.println("오류 발생: " + e.toString());
			//e.printStackTrace();
			//String msg = URLEncoder.encode("도전과제 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage(), StandardCharsets.UTF_8.toString());
			//return "redirect:errorpage.do?error=" + msg + "&url=/challengelist.do";
			return "redirect:/mainpage.do";
		}
	}

	// 체크리스트 체크/해제
	@RequestMapping(value = "/challenge/updateChecklist.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateChecklist(HttpSession session, HttpServletRequest request)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);
		try
		{
			UserDTO user = (UserDTO) session.getAttribute("user");
			if (user == null)
				return "{\"success\":false, \"message\":\"로그인이 필요합니다.\"}";

			String challengeDetailCode = request.getParameter("challengeDetailCode");
			String isChecked = request.getParameter("isChecked");
			String challengeCode = request.getParameter("challengeCode");
			String groupApplyCode = request.getParameter("groupApplyCode");

			// 현재 사용자의 joinCode 조회
			IGroupPostDAO groupDao = sqlSession.getMapper(IGroupPostDAO.class);
			String currentUserJoinCode = groupDao.getJoinCode(groupApplyCode, user.getUserCode());
			System.out.println("currentUserJoinCode" + currentUserJoinCode);
			
			if (currentUserJoinCode == null)
				return "{\"success\":false, \"message\":\"모임원이 아닙니다.\"}";
			
			// challengeMemberCode 조회
			String challengeMemberCode = dao.getChallengeMemberCode(challengeCode, currentUserJoinCode);
			if (challengeMemberCode == null)
				return "{\"success\":false, \"message\":\"참가하지 않은 도전과제입니다.\"}";

			
			// 도전과제 시작일/종료일 확인
			ChallengeInfoDTO challengeDetail = dao.getChallengeDetail(challengeCode);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate startDate = LocalDate.parse(challengeDetail.getStartDate(), formatter);
			LocalDate endDate = null;
			if ("1".equals(challengeDetail.getChallengeType()))
				endDate = startDate.plusDays(7);
			else if ("2".equals(challengeDetail.getChallengeType()))
				endDate = startDate.plusDays(35);
			
			if (endDate != null)
			{
				LocalDate currentDate = LocalDate.now();
				// 시작일 이전이면 수정 불가
				if (currentDate.isBefore(startDate))
					return "{\"success\":false, \"message\":\"도전과제가 아직 시작되지 않았습니다.\"}";
				// 종료일 + 7일 이후면 수정 불가
				LocalDate lastEditDate = endDate.plusDays(7);
				if (currentDate.isAfter(lastEditDate))
					return "{\"success\":false, \"message\":\"수정 기간이 지났습니다.\"}";
			}

			// 체크/해제 처리
			if ("true".equals(isChecked))
			{
				// INSERT
				dao.insertChallengeCheck(challengeMemberCode, challengeDetailCode);
			}
			else
			{
				// DELETE
				dao.deleteChallengeCheck(challengeMemberCode, challengeDetailCode);
			}

			return "{\"success\":true}";
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
			return "{\"success\":false, \"message\":\"처리 중 오류가 발생했습니다.\"}";
		}
	}

}
