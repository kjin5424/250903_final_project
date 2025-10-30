package com.test.mybatis;

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
		return "/WEB-INF/view/manager/group/GroupList.jsp";
	}
	
	@RequestMapping(value="/groupdetail.do", method=RequestMethod.GET)
	public String groupDetail(Model model)
	{
		return "/WEB-INF/view/manager/group/GroupDetail.jsp";
	}
	
	@RequestMapping(value="/groupmodify.do", method=RequestMethod.GET)
	public String groupModify(Model model)
	{
		return "/WEB-INF/view/manager/group/GroupModify.jsp";
	}
	
}
