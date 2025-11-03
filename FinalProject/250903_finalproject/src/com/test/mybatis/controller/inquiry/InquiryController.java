package com.test.mybatis.controller.inquiry;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	InquiryController.java
	- 컨트롤러
======================== */

@Controller
public class InquiryController
{
	@Autowired
	private SqlSession sqlSession;
	
	
		@RequestMapping(value="/inquiry/list.do", method=RequestMethod.GET)
		public String List(Model model)
		{
			return "/WEB-INF/view/inquiry/List.jsp";
		}
	
		@RequestMapping(value="/inquiry/detail.do", method=RequestMethod.GET)
		public String Detail(Model model)
		{
			return "/WEB-INF/view/inquiry/Detail.jsp";
		}
		
		@RequestMapping(value="/inquiry/write.do", method=RequestMethod.GET)
		public String Write(Model model)
		{
			return "/WEB-INF/view/inquiry/Write.jsp";
		}
		

		
}
