package com.test.mybatis.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ErrorController
{
	@RequestMapping(value="/errorpage.do", method=RequestMethod.GET)
	public String errorPage(Model model, String error, String url)
	{
		model.addAttribute("error", error);
		model.addAttribute("url", url);
		return "/WEB-INF/view/common/Error.jsp";
	}
	
	@RequestMapping(value="/getback.do", method=RequestMethod.GET)
	public String getBack(Model model, String url)
	{
		return url;
	}
}
