package com.test.mybatis.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dao.IGroupDAO;
import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.UserDTO;

/* ========================
	SampleController.java
	- 컨트롤러
======================== */

@Controller
public class SampleController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 메인 페이지 임시 구동
	@RequestMapping(value="/mainpage.do")
	public String test(Model model)
	{
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
		try
		{
			ArrayList<GroupDTO> groupList = dao.groupList();
			// 현재 인원 수 구하는 코드
			for (GroupDTO dto : groupList)
			{
				String groupApplyCode = dto.getGroupApplyCode();
				dto.setCurrentMemberCount(dao.groupMemberCount(groupApplyCode));
			}
			
			model.addAttribute("groupList", groupList);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "/WEB-INF/view/group/GroupList.jsp";
	}
	
	// 자격 검증용 코드
	public String testUser(HttpSession session)
	{
		UserDTO user = (UserDTO)session.getAttribute("user");
		if (user == null)
		{
			// 회원 정보 없음
		}
		else
		{
			// 회원 정보 있음
			// 기본적으로 nickName, userCode 존재.
			// 추후 추가할 경우 다룰 때 주의.
		}
		
		return "";
	}
	
	
	@RequestMapping(value="/sample.action", method=RequestMethod.GET)
	public String sample(Model model)
	{
		return "/WEB-INF/view/Sample.jsp";
	}
}
