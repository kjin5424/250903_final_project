package com.test.mybatis.controller.group_room;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberListController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/memberlist.do", method=RequestMethod.GET)
	public String showMemberList(Model model)
	{
		
		return "/WEB-INF/view/group_room/MemberManage.jsp";
	}
}
