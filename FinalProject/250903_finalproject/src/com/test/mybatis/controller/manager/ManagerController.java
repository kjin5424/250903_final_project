package com.test.mybatis.controller.manager;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* ========================
	ManagerController.java
	- 컨트롤러
======================== */

@Controller
public class ManagerController
{
	@Autowired
	private SqlSession sqlSession;
	
		@RequestMapping(value="/managerlogin.do", method=RequestMethod.GET)
		public String managerLogin(Model model)
		{
			return "/WEB-INF/view/manager/authorization/ManagerLogin.jsp";
		}
	
		@RequestMapping(value="/managerregister.do", method=RequestMethod.GET)
		public String managerRegister(Model model)
		{
			return "/WEB-INF/view/manager/authorization/ManagerRegister.jsp";
		}
	
		@RequestMapping(value="/inquirylist_kmj.do", method=RequestMethod.GET)
		public String inquiryList(Model model)
		{
			return "/WEB-INF/view/manager/inquiry/inquiryList_kmj.jsp";
		}
	
		@RequestMapping(value="/inquirydetail.do", method=RequestMethod.GET)
		public String inquiryDetail(Model model)
		{
			return "/WEB-INF/view/manager/inquiry/inquiryDetail.jsp";
		}
		
		@RequestMapping(value="/inquiryopenandanswer.do", method=RequestMethod.GET)
		public String inquiryAnswer(Model model)
		{
			return "/WEB-INF/view/manager/inquiry/InquiryOpenAndAnswer.jsp";
		}
		
		@RequestMapping(value="/managermain.do", method=RequestMethod.GET)
		public String main(Model model)
		{
			return "/WEB-INF/view/manager/main/ManagerMain.jsp";
		}
		
		@RequestMapping(value="/noticedetail.do", method=RequestMethod.GET)
		public String noticeDetail(Model model)
		{
			return "/WEB-INF/view/manager/notice/NoticeDetail.jsp";
		}

		@RequestMapping(value="/noticelist.do", method = RequestMethod.GET)
		public String noticeList(Model model)
		{
			return "/WEB-INF/view/manager/notice/NoticeList.jsp";
		}
		
		@RequestMapping(value="/noticemodify.do", method=RequestMethod.GET)
		public String noticeModify(Model model)
		{
			return "/WEB-INF/view/manager/notice/NoticeModify.jsp";
		}
		
		@RequestMapping(value="/noticewrite.do", method = RequestMethod.GET)
		public String noticeWrite(Model model)
		{
			return "/WEB-INF/view/manager/notice/NoticeWrite.jsp";
		}
		
		@RequestMapping(value="/reportdetail.do", method=RequestMethod.GET)
		public String reportDetail(Model model)
		{
			return "/WEB-INF/view/manager/report/ReportDetail.jsp";
		}
	
		@RequestMapping(value="/reportlist_kmj.do", method=RequestMethod.GET)
		public String reportList(Model model)
		{
			return "/WEB-INF/view/manager/report/ReportList_kmj.jsp";
		}
	
		@RequestMapping(value="/reportexplanation.do", method=RequestMethod.GET)
		public String reportExplanation(Model model)
		{
			return "/WEB-INF/view/manager/report/ReportExplanation.jsp";
		}
		
		@RequestMapping(value="/blind.do", method=RequestMethod.GET)
		public String reportBlind(Model model)
		{
			return "/WEB-INF/view/manager/report/Blind.jsp";
		}
		
		@RequestMapping(value="/blinduserpost.do", method=RequestMethod.GET)
		public String blindUserPost(Model model)
		{
			return "/WEB-INF/view/manager/report/BlindUserPost.jsp";
		}
		
		@RequestMapping(value="/reportuserexplanation.do", method=RequestMethod.GET)
		public String reportUserExplanation(Model model)
		{
			return "/WEB-INF/view/manager/report/ReportUserExplanation.jsp";
		}
		
		@RequestMapping(value="/userlist.do", method=RequestMethod.GET)
		public String userList(Model model)
		{
			return "/WEB-INF/view/manager/user/UserList.jsp";
		}
		
		@RequestMapping(value="/userdetail.do", method=RequestMethod.GET)
		public String userDetail(Model model)
		{
			return "/WEB-INF/view/manager/user/UserDetail.jsp";
		}
		
		@RequestMapping(value="/userposts.do", method=RequestMethod.GET)
		public String userPosts(Model model)
		{
			return "/WEB-INF/view/manager/user/UserPosts.jsp";
		}
		
		@RequestMapping(value="/poll.do", method=RequestMethod.GET)
		public String poll(Model model)
		{
			return "/WEB-INF/view/manager/poll/poll.jsp";
		}
		
		
		
		
		

		
}
