package com.test.mybatis.controller.group_room.challenge;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.HttpRequestHandler;
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
		UserDTO user = (UserDTO)session.getAttribute("user");
		
		// 유저의 joinCode 기반으로 GroupApplyCode 뽑은 후 도전과제 리스트 출력
		// 회원이 아닐 때
		/*
		if (user==null)
		{
			return "redirect:loginpage.do";
		}
		*/
		user.setUserCode("UC00000093");
		
		// 이전 페이지로(group/home.jsp, common/GroupSideBar.jsp, ...)부터 받는 groupApplyCode
		String groupApplyCode = request.getParameter("GroupApplyCode");
		if ("".equals(groupApplyCode))
			groupApplyCode = "16";		//-- 테스트용
		
		boolean flag = false;
		
		// user통해 joinCode 얻기
		// + joinCode로 groupApplyCode 비교 + nickname도 얻어야함
		for (ChallengeDTO userGroup : dao.getJoinCode(user.getUserCode()) )
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
			return "redirect:mainpage.do";
		}
		
		try
		{
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
			, ChallengeDTO dto)
	{
		/*
		System.out.println(dto.getTitle());
		System.out.println(dto.getStartDate());
		System.out.println(dto.getContent());
		System.out.println(dto.getChallengeType());
		if (dto.getChallengeType().equals("daily"))
		{
			System.out.println(request.getParameter("day1"));
			System.out.println(request.getParameter("day2"));
			System.out.println(request.getParameter("day3"));
			System.out.println(request.getParameter("day4"));
			System.out.println(request.getParameter("day5"));
			System.out.println(request.getParameter("day6"));
			System.out.println(request.getParameter("day7"));
		}
		else
		{
			System.out.println("week1");
			System.out.println("week2");
			System.out.println("week3");
			System.out.println("week4");
			System.out.println("week5");
		}
		// challengeType (1 → daily, 2 → weekly)
		*/
		
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);
		
		// 기존 dto에 있는 정보
		// → title, startDate, Content, ChallengeType
		// joinCode DTO에 집어넣기
		UserDTO user = (UserDTO)session.getAttribute("user");
		//String joinCode = dao.getJoinCode(user.getUserCode());
		//dto.setJoinCode(joinCode);
		
		// 도전과제 세부 내용 입력용 DTO
		ChallengeContentDTO contentDTO = new ChallengeContentDTO();
		String type = request.getParameter(dto.getChallengeType());
		
		if ("".equals(type) || type==null)
		{
			throw new NullPointerException();
		}
		
		if (type.equals("daily"))
		{
			contentDTO.setDay1(request.getParameter("day1"));
			contentDTO.setDay2(request.getParameter("day2"));
			contentDTO.setDay3(request.getParameter("day3"));
			contentDTO.setDay4(request.getParameter("day4"));
			contentDTO.setDay5(request.getParameter("day5"));
			contentDTO.setDay6(request.getParameter("day6"));
			contentDTO.setDay7(request.getParameter("day7"));
		}
		else
		{
			contentDTO.setWeek1(request.getParameter("week1"));
			contentDTO.setWeek2(request.getParameter("week2"));
			contentDTO.setWeek3(request.getParameter("week3"));
			contentDTO.setWeek4(request.getParameter("week4"));
			contentDTO.setWeek5(request.getParameter("week5"));
		}
		
		
		return "/WEB-INF/view/group_room/challenge/ChallengeList.jsp";
	}
	
	
	// 도전과제 상세 내용 출력
	@RequestMapping(value="/challengedetailpage.do")
	public String challengeDetailPage(HttpSession session, HttpServletRequest request
			, Model model)
	{
		IChallengeDAO dao = sqlSession.getMapper(IChallengeDAO.class);
		// 이전 페이지에서 받는 정보
		// 세션에서 유저, challengeCode
		//UserDTO user = (UserDTO)session.getAttribute("user");
		String challengeCode = request.getParameter("challengeCode");
		if ("".equals(challengeCode) || challengeCode==null)
			challengeCode = "2";		// 테스트용
		
		// 도전과제 출력
		ChallengeDTO challengeDetail = dao.getChallengeDetail(challengeCode);
		
		// 도전과제 내용 출력
		ArrayList<ChallengeContentDTO> challengeContentList = dao.getChallengeContent(challengeCode);
		
		model.addAttribute("challengeDetail", challengeDetail);
		model.addAttribute("challengeContentList", challengeContentList);
		
		return "/WEB-INF/view/group_room/challenge/ChallengeDetail.jsp";
	}
	
}
