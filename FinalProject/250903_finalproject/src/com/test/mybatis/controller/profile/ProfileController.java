package com.test.mybatis.controller.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IGroupDAO;
import com.test.mybatis.dao.IUserDAO;
import com.test.mybatis.dto.UserDTO;

/* ========================
	ProfileController.java
	- 컨트롤러
======================== */

@Controller
public class ProfileController
{

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	public String calendar(Model model)
	{
		return "/WEB-INF/view/profile/Calendar.jsp";
	}

	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(Model model, HttpSession session)
	{

		UserDTO user = (UserDTO) session.getAttribute("user");
		IUserDAO userDao = sqlSession.getMapper(IUserDAO.class);
		String userCode = "UC00000010";
		IGroupDAO groupDao = sqlSession.getMapper(IGroupDAO.class);

		if (user != null)
		{
			userCode = user.getUserCode();
		}

		model.addAttribute("myGroup", sqlSession.selectList("com.test.mybatis.dao.IGroupDAO.myPageMyGroup", userCode));
		model.addAttribute("joinGroup", sqlSession.selectList("com.test.mybatis.dao.IGroupDAO.myPageJoinGroup", userCode));
		model.addAttribute("myInfo", userDao.inMyPage(userCode));
		model.addAttribute("requestJoinGroup", sqlSession.selectList("com.test.mybatis.dao.IGroupDAO.myPageRequestJoinGroup", userCode));
		model.addAttribute("requestApplyGroup", groupDao.myPageRequestApplyGroup(userCode));
		model.addAttribute("quitGroup", sqlSession.selectList("com.test.mybatis.dao.IGroupJoinDAO.myPageQuitGroup", userCode));
		model.addAttribute("favoriteGroup", sqlSession.selectList("com.test.mybatis.dao.IGroupDAO.myPageFavoriteGroup", userCode));

		return "/WEB-INF/view/profile/Mypage.jsp";
	}

	@RequestMapping(value = "/profile.do", method = RequestMethod.GET)
	public String profile(Model model, @RequestParam("nickName") String nickName, HttpServletRequest request)
	{
		IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
		
		// 세션에서 본인 유저코드 가져오기
		HttpSession session = request.getSession();
		UserDTO userdto = (UserDTO)session.getAttribute("user");
		String userCode = "";
		
		if (userdto==null)
			userCode = "비회원";
		else
			userCode = userdto.getUserCode();
		
		// 회원 닉네임로 회원코드 가져오기
		String user = dao.nickNameToUserCode(nickName);

		int relationCheck = dao.relationCheck(userCode, user);

		System.out.println("RELATION_CHECK : " + relationCheck);

		switch (relationCheck)
		{
		case 1:	// 본인
			return "redirect:/profilemodify.do";
		case 2:	// 모임장
			model.addAttribute("profile", dao.otherProfile(user));
			model.addAttribute("currentGroup",
					sqlSession.selectList("com.test.mybatis.dao.IUserDAO.currentGroupList", user));
			model.addAttribute("quitGroup",
					sqlSession.selectList("com.test.mybatis.dao.IUserDAO.quitGroupList", user));
			model.addAttribute("relation", relationCheck);
			break;
		case 3:	// 모임원
			model.addAttribute("profile", dao.otherProfile(user));
			model.addAttribute("currentGroup",
					sqlSession.selectList("com.test.mybatis.dao.IUserDAO.currentGroupList", user));
			model.addAttribute("quitGroup",
					sqlSession.selectList("com.test.mybatis.dao.IUserDAO.quitGroupList", user));
			model.addAttribute("relation", relationCheck);
			break;
		case 4: // 무관계 
			model.addAttribute("profile", dao.otherProfile(user));
			model.addAttribute("currentGroup",
					sqlSession.selectList("com.test.mybatis.dao.IUserDAO.currentGroupList", user));
			model.addAttribute("quitGroup",
					sqlSession.selectList("com.test.mybatis.dao.IUserDAO.quitGroupList", user));
			model.addAttribute("relation", relationCheck);
		default:
			break;
		}

		// sqlSession.selectList("com.example.mapper.UserMapper.getUserById", userId)
		// Map<String, User> userMap =
		// sqlSession.selectMap("com.example.mapper.UserMapper.getAllUsers",
		// "userCode");

		return "/WEB-INF/view/profile/Profile.jsp";
	}

	@RequestMapping(value = "/profileforgroupmanager.do", method = RequestMethod.GET)
	public String profileForGroupManager(Model model)
	{
		return "/WEB-INF/view/profile/ProfileForGroupManager.jsp";
	}
	
	@RequestMapping(value="/profileupdate.do", method = RequestMethod.GET)
	public String profileUpdate(HttpServletRequest request, HttpSession session)
	{
		String url = "redirect:profilemodify.do";
		
		IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
		
		UserDTO user = (UserDTO)session.getAttribute("user");
		String userCode = "UC00000010";
		
		if(user!=null)
			userCode = user.getUserCode();
		
		UserDTO userDTO = new UserDTO();
		userDTO.setUserCode(userCode);
		userDTO.setNickname(request.getParameter("nickname"));
		userDTO.setAddress(request.getParameter("address"));
		userDTO.setEmail(request.getParameter("email"));
		
		String password = request.getParameter("password");
		
		if(password!=null && !password.equals(""))
		{
			userDTO.setPassword(password);
			userDAO.updateUserInfo(userDTO);
		}
		else
		{
			userDAO.updateUserInfoNotPw(userDTO);
		}
		
		return url;
	}
	
	@RequestMapping(value="/profilemodifycheck.do", method=RequestMethod.GET)
	public void profileModifyCheck(HttpSession session, HttpServletRequest request
				, HttpServletResponse response) throws ServletException, IOException
	{
		String url = "";
				
		UserDTO user = (UserDTO)session.getAttribute("user");
		String userCode = "UC00000010";
		if(user!=null)
			userCode = user.getUserCode();
		
		IUserDAO userDao = sqlSession.getMapper(IUserDAO.class);
		
		String passCheck = userDao.profileModifyCheck(userCode);
		
		if(passCheck.equals(request.getParameter("password")))
			url = "/profilemodify.do";
		else
			url = "/profilemodifycheckpage.do?error=faild";
		
		
		request.getRequestDispatcher(url).forward(request, response);
		
	}
	
	@RequestMapping(value="/profilemodifycheckpage.do", method=RequestMethod.GET)
	public String profileModifyCheckPage(HttpSession session, @RequestParam(value="error", required = false) String error)
	{
		String url = "/WEB-INF/view/profile/ProfileModifyCheck.jsp";
		UserDTO user = (UserDTO)session.getAttribute("user");
		String userCode = "UC00000010";
		if(user!=null)
			userCode = user.getUserCode();
		
		if(error!=null)
			return url + "?error=" + error;
		else
			return url;
	}
	
	/*
	 * @RequestMapping(value = "/profilemodify.do", method = RequestMethod.GET)
	 * public String ProfileModify(Model model) { return
	 * "/WEB-INF/view/profile/ProfileModify.jsp"; }
	 */
}
