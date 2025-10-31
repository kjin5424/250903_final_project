package com.test.mybatis;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dto.UserDTO;

/* ========================
	SampleController.java
	- 컨트롤러
======================== */

@Controller
public class SampleController
{
	// 페이지 테스트 구동용
	@RequestMapping("/start.do")
	public String test()
	{
		return "/WEB-INF/view/group_room/challenge/ChallengeModify.jsp";
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
