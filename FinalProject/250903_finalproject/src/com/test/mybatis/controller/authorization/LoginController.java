/*==========================
	LoginController.java
==========================*/

package com.test.mybatis.controller.authorization;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dao.ILoginDAO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class LoginController
{
	@Autowired
	private SqlSession sqlSession;

	// 페이지 전환용 컨트롤러
	@RequestMapping(value="/loginpage.do", method=RequestMethod.GET)
	public String loginPage()
	{
		return "/WEB-INF/view/authorization/Login.jsp";
	}

	@RequestMapping(value="/findidpage.do")
	public String findIdPage()
	{
		return "/WEB-INF/view/authorization/FindUserId.jsp";
	}

	@RequestMapping(value="/findpwpage.do")
	public String findPwPage()
	{
		return "/WEB-INF/view/authorization/FindPassword.jsp";
	}

	@RequestMapping(value="/signuppage.do")
	public String signUpPage()
	{
		return "/WEB-INF/view/authorization/SignUp.jsp";
	}
	
	
	// 로그인 기능
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String login(HttpSession session, Model model, UserDTO user)
	{
		ILoginDAO dao = sqlSession.getMapper(ILoginDAO.class);
		UserDTO findUser = dao.loginProcess(user);

		// userCode.equals("")하게 되면
		// null.equals("")이렇게 돼서 NullPointerException 발생.
		if (findUser == null)
		{
			model.addAttribute("error", true);			
			return "redirect:/loginpage.do";
		}
		else
		{
			System.out.println("신원 확인\nuserCode : " + findUser.getUserCode());
			session.setAttribute("user", findUser);
		}
		
		return "redirect:start.do";
	}
	
	// 로그아웃
	@RequestMapping(value="/logout.do")
	public String logOut(HttpSession session)
	{
		session.removeAttribute("user");
		
		return "redirect:/start.do";
	}
	
	// 아이디 중복 검사
	@RequestMapping(value="/validateuniqueid.do")
	public String ValidateUniqueId(Model model, String uid)
	{
		ILoginDAO dao = sqlSession.getMapper(ILoginDAO.class);
		int idCount = dao.validId(uid);
		
		model.addAttribute("idCount", idCount);
		
		return "/WEB-INF/view/authorization/ajax/ValidId.jsp";
	}
	
	// 회원가입
	@RequestMapping(value="/signUp.do")
	public String signUp(UserDTO dto)
	{
		
		
		return "redirect:loginpage.do";
	}
	

}
