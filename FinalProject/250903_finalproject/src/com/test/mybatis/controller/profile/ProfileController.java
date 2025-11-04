package com.test.mybatis.controller.profile;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IUserDAO;

/* ========================
	ProfileController.java
	- 컨트롤러
======================== */

@Controller
public class ProfileController {
	
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	public String calendar(Model model) {
		return "/WEB-INF/view/profile/Calendar.jsp";
	}

	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(Model model) {
		return "/WEB-INF/view/profile/Mypage.jsp";
	}

	@RequestMapping(value = "/profile.do", method = RequestMethod.GET)
	public String profile(Model model,@RequestParam("readerUserCode") String readerUserCode,@RequestParam("targetUserCode") String targetUserCode) {
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		int relationCheck = dao.relationCheck(readerUserCode, targetUserCode);
		
		System.out.println("RELATION_CHECK : " + relationCheck);
		
		switch (relationCheck)
		{
			case 1: return "redirect:/profilemodify.do";
			case 2: model.addAttribute("profile", dao.otherProfile(targetUserCode)); 
					model.addAttribute("currentGroup", dao.currentGroupList(targetUserCode)); 
					model.addAttribute("quitGroup", dao.quitGroupList(targetUserCode)); break;
			case 3: model.addAttribute("profile", dao.otherProfile(targetUserCode)); 
					model.addAttribute("currentGroup", sqlSession.selectList("com.test.mybatis.dao.IUserDAO.currentGroupList", targetUserCode)); 
					model.addAttribute("quitGroup", sqlSession.selectList("com.test.mybatis.dao.IUserDAO.quitGroupList", targetUserCode)); break;
			default: break;
		}
		
		//sqlSession.selectList("com.example.mapper.UserMapper.getUserById", userId)
		// Map<String, User> userMap = sqlSession.selectMap("com.example.mapper.UserMapper.getAllUsers", "userCode");
		
		
		return "/WEB-INF/view/profile/Profile.jsp";
	}

	@RequestMapping(value = "/profileforgroupmanager.do", method = RequestMethod.GET)
	public String profileForGroupManager(Model model) {
		return "/WEB-INF/view/profile/ProfileForGroupManager.jsp";
	}
	
	@RequestMapping(value = "/profilemodify.do", method = RequestMethod.GET)
	public String ProfileModify(Model model) {
		return "/WEB-INF/view/profile/ProfileModify.jsp";
	}
}
