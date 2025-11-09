package com.test.mybatis.controller.group_room;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dao.IGroupPostDAO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class MessageController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/writemessage.do", method=RequestMethod.GET)
	public String writeMessage(Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		UserDTO dto = (UserDTO)session.getAttribute("user");
		String userCode = dto.getUserCode();
		String groupApplyCode = (String)session.getAttribute("groupApplyCode");
		
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		String joinCode = dao.getJoinCode(groupApplyCode, userCode); 
		
		model.addAttribute("joinCode", joinCode);
		model.addAttribute("groupApplyCode", groupApplyCode);
		
		return "/WEB-INF/view/group_room/MessageWrite.jsp";
	}
}
