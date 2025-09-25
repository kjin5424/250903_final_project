package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// - 사용자 정의 컨트롤러

// ※ Spring MVC의 『Controller』 인터페이스를 구현하는 방법을 통해
//    사용자 정의 컨트롤러 클래스를 구성할 수 있도록 한다.

public class SampleController implements Controller
{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// Controller가 수행해야 하는 액션 코드
		ModelAndView mav = new ModelAndView();
		
		// 결과 처리에 따른 반환값으로 분기처리하여 어쩌구 저쩌구
		
		// 최종 결과값 반환
		return mav;
	}
	
}
