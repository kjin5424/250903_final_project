package com.test.mybatis.controller.group_room.challenge;

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

import com.test.mybatis.dao.IChallengeDAO;
import com.test.mybatis.dto.ChallengeContentDTO;
import com.test.mybatis.dto.ChallengeDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class ChanllengeController {
	
	@Autowired
	private SqlSession sqlSession;

	
	// 도전과제 리스트 출력
	@RequestMapping(value="/challengelist.do")
	public String challengeList(Model model, HttpSession session, HttpServletRequest request)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);

		// 유저의 joinCode 기반으로 GroupApplyCode 뽑은 후 도전과제 리스트 출력
		try
		{
			UserDTO user = (UserDTO)session.getAttribute("user");
			
			// 회원이 아닐 때
			if (user == null) {
			    String msg = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
			    return "redirect:errorpage.do?error=" + msg + "&url=loginpage.do";
			}
			
			// 이전 페이지로(group/home.jsp, common/GroupSideBar.jsp, ...)부터 받는 groupApplyCode
			String groupApplyCode = request.getParameter("GroupApplyCode");
			
			if ("".equals(groupApplyCode) || groupApplyCode==null)
				groupApplyCode = "91";		//-- 테스트용
			
			boolean flag = false;
			
			// user통해 joinCode 얻기
			// + joinCode로 groupApplyCode 비교 + nickname도 얻어야함
			for (ChallengeDTO userGroup : dao.getJoinCodes(user.getUserCode()) )
			{
				if (groupApplyCode.equals(userGroup.getGroupApplyCode()))
				{
					flag = true;
					break;
				}
			}
			
			// 모임원이 아니라면 메인페이지로
			if (!flag)
			{
				return "redirect:/mainpage.do";
			}
			

			// 찾은 groupApplyCode로 리스트 출력
			ArrayList<ChallengeDTO> challengeList = dao.challengeList(groupApplyCode);
			
			// 가져온 속성
			// → challengeCode, joinCode, challengeType, title, startDate, content, createdDate
			// 필요한 속성
			// → endDate, status + nickname
			
			// 필요 속성 구하기
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			for (ChallengeDTO dto : challengeList)
			{
				// 종료 날짜 구하기
				LocalDate startDate = LocalDate.parse(dto.getStartDate(), formatter);
				LocalDate endDate=null;
				
				if ("1".equals(dto.getChallengeType()))			// 주간 과제
					endDate = startDate.plusDays(7);
				else if ("2".equals(dto.getChallengeType()))	// 월간 과제
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
			}
			
			model.addAttribute("challengeList", challengeList);
				

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "/WEB-INF/view/group_room/challenge/ChallengeList.jsp";
	}
	
	
	// 도전과제 등록 페이지 출력
	@RequestMapping(value="/challengecreatepage.do")
	public String createChallengePage()
	{
		return "/WEB-INF/view/group_room/challenge/ChallengeCreate.jsp";
	}
	
	
	// 도전과제 등록 프로세스
	@RequestMapping(value="/challengecreate.do", method=RequestMethod.POST)
	public String createChallenge(HttpSession session, HttpServletRequest request
			, ChallengeDTO challengeDto)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);
		
		// 기존 dto에 있는 정보
		// → title, startDate, Content, ChallengeType
		// joinCode DTO에 집어넣기
		UserDTO user = (UserDTO)session.getAttribute("user");
		//String joinCode = dao.getJoinCode(user.getUserCode());
		//dto.setJoinCode(joinCode);
		user = new UserDTO();
		user.setUserCode("UC00000093");
		
		String groupApplyCode = request.getParameter("groupApplyCode");
		String joinCode = "";
		
		if ("".equals(groupApplyCode) || groupApplyCode==null)
		{
			groupApplyCode = "91";
		}
		
		boolean flag = false;
		
		for (ChallengeDTO list : dao.getJoinCodes(user.getUserCode()) )
		{
			if (groupApplyCode.equals(list.getGroupApplyCode()))
			{
				flag = true;
				joinCode = list.getJoinCode();
				break;
			}
		}
		
		if (!flag)
		{
			System.out.println("null 문제 발생");
		}
		
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
		}
		else
		{
			contentDto.setChallengeType("2");
			contentDto.setWeek1(request.getParameter("week1"));
			contentDto.setWeek2(request.getParameter("week2"));
			contentDto.setWeek3(request.getParameter("week3"));
			contentDto.setWeek4(request.getParameter("week4"));
			contentDto.setWeek5(request.getParameter("week5"));
		}
		
		System.out.println(contentDto.getJoinCode());
		System.out.println(contentDto.getTitle());
		System.out.println(contentDto.getContent());
		System.out.println(contentDto.getChallengeType());
		System.out.println(contentDto.getStartDate());
		System.out.println(contentDto.getDay4());
		
		dao.challengeCreate(contentDto);
		
		return "redirect:/challengelist.do";
	}
	
	
	// 도전과제 상세 내용 출력
	@RequestMapping(value="/challengedetailpage.do")
	public String challengeDetailPage(HttpSession session, HttpServletRequest request
			, Model model)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);
		// 이전 페이지에서 받는 정보
		// 세션에서 유저, challengeCode
		UserDTO user = (UserDTO)session.getAttribute("user");
		String challengeCode = request.getParameter("challengeCode");
		
		
		try
		{
			// 회원이 아닐 때
			if (user == null) {
				String msg = URLEncoder.encode("로그인이 필요합니다.", StandardCharsets.UTF_8.toString());
				return "redirect:errorpage.do?error=" + msg + "&url=loginpage.do";
			}
			
			// 도전과제 정보 출력
			// (도전과제코드, 작성자, 제목, 내용, 유형, 시작일, 작성일)
			ChallengeDTO challengeDetail = dao.getChallengeDetail(challengeCode);
			
			// 종료 날짜 구하기
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate startDate = LocalDate.parse(challengeDetail.getStartDate(), formatter);
			LocalDate endDate=null;
			
			if ("1".equals(challengeDetail.getChallengeType()))			// 주간 과제
				endDate = startDate.plusDays(7);
			else if ("2".equals(challengeDetail.getChallengeType()))	// 월간 과제
				endDate = startDate.plusDays(35);
			
			challengeDetail.setEndDate(endDate.format(formatter));
			
			// 도전과제 내용 출력
			// (회차, 내용, 식별코드(challengeDetailCode))
			ArrayList<ChallengeContentDTO> challengeContentList = dao.getChallengeContent(challengeCode);
			
			
			
			
			
			/*
			 * <p>참가자 : 8 명</p> <p>달성자 : 5 명</p> <p>달성률 : 62.5 %</p>
			 */
			
			
			
			model.addAttribute("challengeDetail", challengeDetail);
			model.addAttribute("challengeContentList", challengeContentList);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "WEB-INF/view/group_room/challenge/ChallengeDetail.jsp";
	}
	
}
