package com.test.mybatis.controller.group;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dao.IGroupPostDAO;
import com.test.mybatis.dao.IMessageDAO;
import com.test.mybatis.dto.MessageDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class MessageController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/messagelist.do", method=RequestMethod.GET)
	public String messageList(Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		UserDTO dto = (UserDTO)session.getAttribute("user");
		if (dto!= null)
		{
			String userCode = dto.getUserCode();
			IGroupPostDAO daogp = sqlSession.getMapper(IGroupPostDAO.class);
			String groupApplyCode = (String)session.getAttribute("groupApplyCode");
			
			if (groupApplyCode!=null)
			{
				String joinCode = (String)daogp.getJoinCode(groupApplyCode, userCode);
				
				if (joinCode != null)
				{
					IMessageDAO daom = sqlSession.getMapper(IMessageDAO.class);
					ArrayList<MessageDTO> receivedMessage = daom.getReceivedMessage(groupApplyCode, joinCode);
					ArrayList<MessageDTO> forwardedMessage = daom.getForwardedMessage(groupApplyCode, joinCode);
					model.addAttribute("receivedMessage", receivedMessage);
					model.addAttribute("forwardedMessage", forwardedMessage);
					return "/WEB-INF/view/group_room/MessageList.jsp";
				}
				else
				{
					model.addAttribute("error", "쪽지를 조회하려면 모임에 가입해야 합니다.");
			    	model.addAttribute("url", "/home.do?groupApplyCode=" + groupApplyCode);
			    	return "redirect:/errorpage.do";
				}
			}
			else
			{
				model.addAttribute("error", "잘못된 접근입니다..");
		    	model.addAttribute("url", "/mainpage.do");
		    	return "redirect:/errorpage.do";
			}
		}
		else
		{
			model.addAttribute("error", "쪽지를 조회하려면 모임에 가입해야 합니다.");
	    	model.addAttribute("url", "/loginpage.do");
	    	return "redirect:/errorpage.do";
		}
	}
	
	@RequestMapping(value="/writemessage.do", method=RequestMethod.GET)
	public String writeMessage(Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		IMessageDAO dao1 = sqlSession.getMapper(IMessageDAO.class);
		IGroupPostDAO dao2 = sqlSession.getMapper(IGroupPostDAO.class);
		
		UserDTO dto = (UserDTO)session.getAttribute("user");
		String userCode = dto.getUserCode();
		String groupApplyCode = (String)session.getAttribute("groupApplyCode");
		
		ArrayList<MessageDTO> userList = dao1.getUserList(groupApplyCode);
		String joinCode = dao2.getJoinCode(groupApplyCode, userCode); 

		model.addAttribute("forwarder", joinCode);
		model.addAttribute("groupApplyCode", groupApplyCode);
		model.addAttribute("userList", userList);
		String nickName = request.getParameter("nickName");
		if (nickName!=null)
			model.addAttribute("nickName", nickName);
			
		return "/WEB-INF/view/group_room/MessageWrite.jsp";
	}
	
	@RequestMapping(value="/messagewriteOk.do", method=RequestMethod.POST)
	public String writeMessageOk(Model model, HttpServletRequest request)
	{
		String receiver = request.getParameter("receiver");
		String content = request.getParameter("content");
		System.out.println(receiver);
		System.out.println(content);
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("user");
		String groupApplyCode = (String)session.getAttribute("groupApplyCode");
		String userCode = user.getUserCode();
		IGroupPostDAO daogp = sqlSession.getMapper(IGroupPostDAO.class);
		String forwarder = daogp.getJoinCode(groupApplyCode, userCode);
		
		MessageDTO dto = new MessageDTO();
		dto.setReceiver(receiver);
		dto.setForwarder(forwarder);
		dto.setContent(content);
		
		IMessageDAO daom = sqlSession.getMapper(IMessageDAO.class);
		daom.sendMessage(dto);
		
		return "redirect:/messagelist.do";
	}
	
	@RequestMapping(value="/messageread.do", method=RequestMethod.POST)
	public String messageRead(String messageCode)
	{
		IMessageDAO dao = sqlSession.getMapper(IMessageDAO.class);
		try
		{
			dao.readMessage(messageCode);
			return "success";
			
		} catch (Exception e)
		{
			e.printStackTrace();
			return "false";
		}
	}
	
	@RequestMapping(value="/receivedmessagedelete.do", method=RequestMethod.GET)
	public String deleteReceMessage(String messageCode)
	{
		IMessageDAO dao = sqlSession.getMapper(IMessageDAO.class);
		
		dao.deleteReceivedMessage(messageCode);
		
		return "redirect:/messagelist.do";
	}

	@RequestMapping(value="/forwardedmessagedelete.do", method=RequestMethod.GET)
	public String deleteMessage(String messageCode)
	{
		IMessageDAO dao = sqlSession. getMapper(IMessageDAO.class);
		
		dao.deleteForwardedMessage(messageCode);
		
		return "redirect:/messagelist.do";
	}
}
