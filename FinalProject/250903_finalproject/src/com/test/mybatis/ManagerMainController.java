package com.test.mybatis;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerMainController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerMainController
{
	@RequestMapping(value="/managermain.do", method=RequestMethod.GET)
	public String main(Model model)
	{
		return "/WEB-INF/view/manager/main/ManagerMain.jsp";
	}
}
