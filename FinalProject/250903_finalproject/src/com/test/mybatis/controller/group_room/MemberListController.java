package com.test.mybatis.controller.group_room;

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
import com.test.mybatis.dao.IGroupMemberDAO;
import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.UserDTO;

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
		UserDTO user = (UserDTO)session.getAttribute("user");
		
		// 유저를 세션에서 가져와서
		// 그룹아이디코드를 가지고 해당 그룹에 참여중인지 확인이 필요함
		// 참여중이라면? 모임장인지 아닌지 확인이 필요함
		String position = "";
		
		if (user!=null)
		{
			String userCode = user.getUserCode();
			IGroupMemberDAO dao2 = sqlSession.getMapper(IGroupMemberDAO.class);
			position = dao2.checkMemberGroup(userCode, groupApplyCode);
		}
		else
			position = "비회원";
		
		List<GroupDTO> groupUserList = dao.groupUserList(groupApplyCode);
		GroupDTO group = dao.groupDetail(groupApplyCode);
		String title = group.getGroupTitle();
		
		model.addAttribute("groupUserList", groupUserList);
		model.addAttribute("title", title);
		model.addAttribute("position", position);
		
		return "/WEB-INF/view/group_room/MemberList.jsp";
	}
}
