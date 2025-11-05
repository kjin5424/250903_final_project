package com.test.mybatis.controller.manager.group;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerGroupController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerGroupController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/grouplist.do", method=RequestMethod.GET)
	public String groupList(Model model)
	{
		return "/WEB-INF/view/group/GroupList.jsp";
	}
	
	@RequestMapping(value="/grouplistdetail.do", method=RequestMethod.GET)
	public String groupDetail(Model model)
	{
		return "/WEB-INF/view/group/GroupListDetail.jsp";
	}
	
	@RequestMapping(value="/groupmodify.do", method=RequestMethod.GET)
	public String groupModify(Model model)
	{
		return "/WEB-INF/view/manager/group/GroupModify.jsp";
	}
	
	
	@RequestMapping(value="/beforegroupcreate.do", method=RequestMethod.GET)
	public String beforeGroupCreate(Model model)
	{
		return "/WEB-INF/view/group/BeforeGroupCreate.jsp";
	}
	
	@RequestMapping(value="/groupcreatemodify.do", method=RequestMethod.GET)
	public String groupCreateModify(Model model)
	{
		return "/WEB-INF/view/group/GroupCreateModify.jsp";
	}
	
	
	
}
