package com.test.spr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class GroupHomeController implements Controller
{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// ���� ������ (����ȭ��, ����������) ���� �Ѿ��
		// �׷� ��ȣ(���� ��ȣ) ����
		
		
		// ������ ��ȣ�� �����ͺ��̽����� ���� ȹ��
		// ����, ����, ���� �� �ð�, �ο���, ����������Ʈ, �Խñ�, ��ǥ, �������� ���
		
		
		mav.setViewName("WEB-INF/view/GroupHome.jsp");
		
		return mav;
	}

}
