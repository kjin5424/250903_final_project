package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ProfileController.java
	- 컨트롤러
======================== */

@Controller
public class ProfileController {
	
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	public String calendar(Model model) {
		return "/WEB-INF/view/profile/Calendar.jsp";
	}

	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(Model model) {
		return "/WEB-INF/view/profile/Mypage.jsp";
	}

	@RequestMapping(value = "/profile.do", method = RequestMethod.GET)
	public String profile(Model model) {
		return "/WEB-INF/view/profile/Profile.jsp";
	}

	@RequestMapping(value = "/profileforgroupmanager.do", method = RequestMethod.GET)
	public String profileForGroupManager(Model model) {
		return "/WEB-INF/view/profile/ProfileForGroupManager.jsp";
	}
	
	@RequestMapping(value = "/profilemodify.do", method = RequestMethod.GET)
	public String ProfileModify(Model model) {
		return "/WEB-INF/view/profile/ProfileModify.jsp";
	}
}
