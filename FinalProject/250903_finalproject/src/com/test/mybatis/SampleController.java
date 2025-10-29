package com.test.mybatis;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	SampleController.java
	- 컨트롤러
======================== */

@Controller
public class SampleController
{
	@RequestMapping(value="/sample.action", method=RequestMethod.GET)
	public String sample(Model model)
	{
		
		return "/WEB-INF/view/Sample.jsp";
	}
}
