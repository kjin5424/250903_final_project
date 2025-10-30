package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerInquiryController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerInquiryController
{
	@Autowired
	private SqlSession sqlSession;
	
		@RequestMapping(value="/inquirylist_kmj.do", method=RequestMethod.GET)
		public String inquiryList(Model model)
		{
			return "/WEB-INF/view/manager/inquiry/inquiryList_kmj.jsp";
		}
	
		@RequestMapping(value="/inquirydetail.do", method=RequestMethod.GET)
		public String inquiryDetail(Model model)
		{
			return "/WEB-INF/view/manager/inquiry/inquiryDetail.jsp";
		}
		
		@RequestMapping(value="/inquiryopenandanswer.do", method=RequestMethod.GET)
		public String inquiryAnswer(Model model)
		{
			return "/WEB-INF/view/manager/inquiry/InquiryOpenAndAnswer.jsp";
		}
	
}
