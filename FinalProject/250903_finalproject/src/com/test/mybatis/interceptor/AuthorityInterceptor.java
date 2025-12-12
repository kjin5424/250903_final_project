package com.test.mybatis.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.test.mybatis.dao.IUserDAO;
import com.test.mybatis.dto.UserDTO;

public class AuthorityInterceptor implements HandlerInterceptor
{
	@Autowired
    private SqlSession sqlSession;

	@Override
	// afterCompletion() - view페이지가 렌더링 되고 난 후에 실행됩니다.
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	// postHanler() - 컨트롤러 메서드 실행직후 view페이지 렌더링 되기 전에 실행됩니다.
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	// preHandler() - 컨트롤러 메서드가 실행되기 전에 실행됩니다.
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object obj) throws Exception
	{
		UserDTO user = (UserDTO)req.getSession().getAttribute("user");
        String groupApplyCode = req.getParameter("groupApplyCode");
		//String groupApplyCode = (String)req.getSession().getAttribute("groupApplyCode");
		
		int authority = -1;
		// -1 로그인 안함
		//  0 로그인함+비멤버
		//  1 로그인함+모임장
		//  2 로그인함+부모임장
		//  3 로그인함+도우미
		//  4 로그인함+모임원 

		if (user!=null)
		{
			authority = 0;

			if (groupApplyCode!=null)
			{
				IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
				
				String userCode = user.getUserCode();
				String isMember = dao.checkMember(userCode, groupApplyCode);
				
				// 멤버일 경우 포지션 확인
				if (isMember!=null)
					authority = dao.checkPosition(userCode, groupApplyCode);
			}
		}
		
		req.setAttribute("authority", authority);
		
		return true;
	}
}
