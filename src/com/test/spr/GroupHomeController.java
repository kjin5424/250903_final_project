package com.test.spr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class GroupHomeController implements Controller
{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지 (메인화면, 마이페이지) 에서 넘어온
		// 그룹 번호(개설 번호) 수신
		
		
		// 수신한 번호로 데이터베이스에서 정보 획득
		// 제목, 주제, 요일 및 시간, 인원수, 구성원리스트, 게시글, 투표, 도전과제 등등
		
		
		mav.setViewName("WEB-INF/view/GroupHome.jsp");
		
		return mav;
	}

}
