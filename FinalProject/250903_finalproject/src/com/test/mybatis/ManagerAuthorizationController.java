package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerAuthorizationController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerAuthorizationController
{
	@Autowired
	private SqlSession sqlSession;
	
		@RequestMapping(value="/managerlogin.do", method=RequestMethod.GET)
		public String login(Model model)
		{
			return "/WEB-INF/view/manager/authorization/ManagerLogin.jsp";
		}
	
		@RequestMapping(value="/managerregister.do", method=RequestMethod.GET)
		public String ManagerRegister(Model model)
		{
			return "/WEB-INF/view/manager/authorization/ManagerRegister.jsp";
		}
	
}
