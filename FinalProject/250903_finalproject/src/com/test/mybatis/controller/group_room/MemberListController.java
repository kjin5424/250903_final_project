package com.test.mybatis.controller.group_room;

<<<<<<< Upstream, based on develop
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dao.IGroupDAO;
import com.test.mybatis.dto.GroupDTO;

@Controller
public class MemberListController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/memberlist.do", method=RequestMethod.GET)
	public String showMemberList(Model model, HttpServletRequest request)
	{
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		HttpSession session = request.getSession();
		
		String groupApplyCode = (String)session.getAttribute("groupApplyCode");
		
		List<GroupDTO> groupUserList = dao.groupUserList(groupApplyCode);
		GroupDTO group = dao.groupDetail(groupApplyCode);
		String title = group.getGroupTitle();
		
		model.addAttribute("groupUserList", groupUserList);
		model.addAttribute("title", title);
		System.out.println(title);
		System.out.println(groupUserList);
		for (GroupDTO dto : groupUserList)
		{
			System.out.println(dto.getNickName());
		}
		
		
		return "/WEB-INF/view/group_room/MemberList.jsp";
=======
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
>>>>>>> 9991747 멤버리스트
	}
}
