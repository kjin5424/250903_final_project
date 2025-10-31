package com.test.mybatis.controller.manager.report;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerReportController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerReportController
{
	@Autowired
	private SqlSession sqlSession;
	
		@RequestMapping(value="/reportdetail.do", method=RequestMethod.GET)
		public String reportDetail(Model model)
		{
			return "/WEB-INF/view/manager/report/ReportDetail.jsp";
		}
	
		@RequestMapping(value="/reportlist_kmj.do", method=RequestMethod.GET)
		public String reportList(Model model)
		{
			return "/WEB-INF/view/manager/report/ReportList_kmj.jsp";
		}
	
		@RequestMapping(value="/reportexplanation.do", method=RequestMethod.GET)
		public String reportExplanation(Model model)
		{
			return "/WEB-INF/view/manager/report/ReportExplanation.jsp";
		}
		
		
	
}
