package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerUserController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerUserController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/userlist.do", method=RequestMethod.GET)
	public String userList(Model model)
	{
		return "/WEB-INF/view/manager/user/UserList.jsp";
	}
	
	@RequestMapping(value="/userdetail.do", method=RequestMethod.GET)
	public String userDetail(Model model)
	{
		return "/WEB-INF/view/manager/user/UserDetail.jsp";
	}
	
	@RequestMapping(value="/userposts.do", method=RequestMethod.GET)
	public String userPosts(Model model)
	{
		return "/WEB-INF/view/manager/user/UserPosts.jsp";
	}
	
}
