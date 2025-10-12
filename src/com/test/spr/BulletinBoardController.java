package com.test.spr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class BulletinBoardController implements Controller
{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 자격 검증...(모임원인지 아닌지)
		
		
		// 기능 수행
		String groupId = request.getParameter("groupId");
		
		mav.addObject("groupId", groupId);
		mav.setViewName("/WEB-INF/view/BulletinBoard.jsp");
		
		return mav;
	}
	
}
