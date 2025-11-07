package com.test.mybatis.controller.report;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IInquiryDAO;
import com.test.mybatis.dto.InquiryDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class ReportController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/reportafter.do", method=RequestMethod.GET)
	public String reportAfter(Model model)
	{
		return "/WEB-INF/view/report/ReportAfter.jsp";
	}

	@RequestMapping(value = "/reportcontent.do", method = RequestMethod.GET)
	public String reportContent(Model model) {
		return "/WEB-INF/view/report/ReportContent.jsp";
	}
	
	@RequestMapping(value = "/reportgroup.do", method = RequestMethod.GET)
	public String reportGroup(Model model) {
		return "/WEB-INF/view/report/ReportGroup.jsp";
	}

	@RequestMapping(value = "/reportmember.do", method = RequestMethod.GET)
	public String reportMember(Model model) {
		return "/WEB-INF/view/report/ReportMember.jsp";
	}


}
