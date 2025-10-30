package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerNoticeController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerNoticeController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/noticedetail.do", method=RequestMethod.GET)
	public String noticeDetail(Model model)
	{
		return "/WEB-INF/view/manager/notice/NoticeDetail.jsp";
	}

	@RequestMapping(value="/noticelist.do", method = RequestMethod.GET)
	public String noticeList(Model model)
	{
		return "/WEB-INF/view/manager/notice/NoticeList.jsp";
	}
	
	@RequestMapping(value="/noticemodify.do", method=RequestMethod.GET)
	public String noticeModify(Model model)
	{
		return "/WEB-INF/view/manager/notice/NoticeModify.jsp";
	}
	
	@RequestMapping(value="/noticewrite.do", method = RequestMethod.GET)
	public String noticeWrite(Model model)
	{
		return "/WEB-INF/view/manager/notice/NoticeWrite.jsp";
	}
	
	
}
