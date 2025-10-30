package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	NoticeController.java
	- 컨트롤러
======================== */

@Controller
public class NoticeController {
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String list(Model model) {
		return "/WEB-INF/view/notice/List.jsp";
	}

	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public String detail(Model model) {
		return "/WEB-INF/view/notice/Detail.jsp";
	}

}
