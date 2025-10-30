/*==========================
	LoginController.java
==========================*/

package com.test.mybatis;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController
{
	@Autowired
	private SqlSession sqlSession;

	// 페이지 전환용 컨트롤러
	@RequestMapping("/loginpage.do")
	public String loginPage()
	{
		return "/WEB-INF/view/authorization/Login.jsp";
	}

	@RequestMapping("/findidpage.do")
	public String findIdPage()
	{
		return "/WEB-INF/view/authorization/FindUserId.jsp";
	}

	@RequestMapping("/findpwpage.do")
	public String findPwPage()
	{
		return "/WEB-INF/view/authorization/FindPassword.jsp";
	}

	@RequestMapping("/signuppage.do")
	public String signUpPage()
	{
		return "/WEB-INF/view/authorization/SignUp.jsp";
	}

	// 로그인 기능
	@RequestMapping(value="/login.do")
	public String login(HttpSession session, UserDTO user)
	{
		ILoginDAO dao = sqlSession.getMapper(ILoginDAO.class);
		String userCode = "";
		userCode = dao.loginProcess(user);

		// userCode.equals("")하게 되면
		// null.equals("")이렇게 돼서 NullPointerException 발생.
		if (!user.getUserId().equals(dao.findId(user)))
		{
			System.out.println("아이디 없음");
			return "redirect:/loginpage.do";
		}
		else if ("".equals(userCode) || userCode == null)
		{
			System.out.println("비밀번호 틀림");
			return "redirect:/loginpage.do";
		}
		else
		{
			System.out.println("신원 확인\nuserCode : " + userCode);
			session.setAttribute("userCode", userCode);
		}
		
		return "/WEB-INF/view/group/GroupList.jsp";
	}
	
	@RequestMapping("/logout.do")
	public String logOut(HttpSession session)
	{
		session.removeAttribute("userCode");
		
		return "redirect:/start.do";
	}

	// 메인 페이지 구동용 여기서는 안 써도 될듯함..
	@RequestMapping("/start.do")
	public String mainPage(Model model)
	{
		return "/WEB-INF/view/group_room/challenge/CreateChallenge.jsp";
	}

}
