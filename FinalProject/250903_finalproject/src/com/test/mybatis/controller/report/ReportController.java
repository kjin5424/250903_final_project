package com.test.mybatis.controller.report;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dao.IReportDAO;
import com.test.mybatis.dto.ReportDTO;

@Controller
public class ReportController {

	@Autowired
	private SqlSession sqlSession;

	// 신고 완료
	@RequestMapping(value = "/reportafter.do", method = RequestMethod.GET)
	public String reportAfter(Model model) {
		return "/WEB-INF/view/report/ReportAfter.jsp";
	}

	// 신고 작성 페이지 (GET)
	@RequestMapping(value = "/reportgroup.do", method = RequestMethod.GET)
	public String reportGroupForm() {
		return "/WEB-INF/view/report/ReportGroup.jsp";
	}

	// 모임 신고 제출 처리
	@RequestMapping(value = "/reportgroup.do", method = RequestMethod.POST)
	public String reportSubmit(ReportDTO dto) {
		IReportDAO dao = sqlSession.getMapper(IReportDAO.class);

		dao.insertReport(dto);

		// return "/WEB-INF/view/report/ReportGroup.jsp";

		return "redirect:reportafter.do";
	}

	// 컨텐츠 신고 작성 페이지
	@RequestMapping(value = "/reportcontent.do", method = RequestMethod.GET)
	public String reportContentForm() {
		return "/WEB-INF/view/report/ReportContent.jsp";
	}

	// 컨텐츠 신고 제출 처리
	@RequestMapping(value = "/reportcontent.do", method = RequestMethod.POST)
	public String reportContentSubmit(ReportDTO dto) {
		IReportDAO dao = sqlSession.getMapper(IReportDAO.class);

		// 컨텐츠 신고만 필요한 필드를 채우고 나머지는 null로 처리
		dao.insertContent(dto);

		return "redirect:/reportafter.do";
	}

	// 모임원 신고 작성 페이지 (GET)
	@RequestMapping(value = "/reportmember.do", method = RequestMethod.GET)
	public String reportMemberForm(Model model) {
		return "/WEB-INF/view/report/ReportMember.jsp";
	}

	// 모임원 신고 제출 처리 (POST)
	@RequestMapping(value = "/reportmember.do", method = RequestMethod.POST)
	public String reportMemberSubmit(ReportDTO dto) {
		IReportDAO dao = sqlSession.getMapper(IReportDAO.class);

		dao.insertMember(dto);

		return "redirect:reportafter.do";
	}

}
