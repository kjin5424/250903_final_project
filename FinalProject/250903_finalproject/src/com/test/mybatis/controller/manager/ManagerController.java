package com.test.mybatis.controller.manager;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.test.mybatis.dao.IGroupJoinDAO;
import com.test.mybatis.dao.IInquiryDAO;
import com.test.mybatis.dao.INoticeDAO;
import com.test.mybatis.dao.IReportDAO;
import com.test.mybatis.dao.IUserDAO;
import com.test.util.Paging;

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
	
		/*
		@RequestMapping(value="/inquirydetail.do", method=RequestMethod.GET)
		public String inquiryDetail(Model model)
		{
			return "/WEB-INF/view/manager/inquiry/inquiryDetail.jsp";
		}
		*/
		
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
		
		@RequestMapping(value="/noticewriteaction.do", method = RequestMethod.POST)
		public String noticeWrite(@Param("subject") String subject, @Param("content") String content)
		{
			
			
			return "redirect:noticelist.do?pageNum=1";
		}
		
		@RequestMapping(value="/managernoticedetail.do", method=RequestMethod.GET)
		public String noticeDetail(Model model, String noticecode, String pageNum)
		{
			INoticeDAO noticeDao = sqlSession.getMapper(INoticeDAO.class);
			
			model.addAttribute("noticeDTO", noticeDao.noticeDetailForManager( noticecode));
			model.addAttribute("pageNum", pageNum);
			
			return "/WEB-INF/view/manager/notice/NoticeDetail.jsp";
		}

		@RequestMapping(value="/noticelist.do", method = RequestMethod.GET)
		public String noticeList(Model model, String pageNum, HttpServletRequest request)
		{
			INoticeDAO noticeDao = sqlSession.getMapper(INoticeDAO.class);
			
			
			int currentPage = 1;	// 기본값
			if (pageNum != null)
				currentPage = Integer.parseInt(pageNum);
			
			// 전체 데이터 개수 구하기
			int dataCount = noticeDao.listCount();
			int numPerPage = 10;	// 한 페이지에 표시할 데이터 개수
			
			Paging paging = new Paging();
			int totalPage = paging.getPageCount(numPerPage, dataCount);
			
			if (currentPage > totalPage)
				currentPage = totalPage;
			
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;
				
			// url 생성
			String cp = request.getContextPath();
			String listUrl = cp + "/noticelist.do";
			String pageIndexList = paging.pageIndexList(currentPage, totalPage, listUrl);
			
			// model에 데이터 담기
			model.addAttribute("noticeList", noticeDao.noticeListForManager(start, end));
			model.addAttribute("pageIndexList", pageIndexList);
			model.addAttribute("pageNum", currentPage);
			model.addAttribute("count", noticeDao.listCount());
			
			// 주소 구성
			String articleUrl = "/WEB-INF/view/manager/notice/NoticeList.jsp";
			articleUrl += "?pageNum=" + currentPage;
						
			return articleUrl;
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
		
		/*
		 * @RequestMapping(value="/reportdetail.do", method=RequestMethod.GET) public
		 * String reportDetail(Model model) { return
		 * "/WEB-INF/view/manager/report/ReportDetail.jsp"; }
		 * 
		 * @RequestMapping(value="/reportlist_kmj.do", method=RequestMethod.GET) public
		 * String reportList(Model model) { return
		 * "/WEB-INF/view/manager/report/ReportList_kmj.jsp"; }
		 * 
		 * @RequestMapping(value="/reportexplanation.do", method=RequestMethod.GET)
		 * public String reportExplanation(Model model) { return
		 * "/WEB-INF/view/manager/report/ReportExplanation.jsp"; }
		 * 
		 * @RequestMapping(value="/blind.do", method=RequestMethod.GET) public String
		 * reportBlind(Model model) { return "/WEB-INF/view/manager/report/Blind.jsp"; }
		 * 
		 * @RequestMapping(value="/blinduserpost.do", method=RequestMethod.GET) public
		 * String blindUserPost(Model model) { return
		 * "/WEB-INF/view/manager/report/BlindUserPost.jsp"; }
		 * 
		 * @RequestMapping(value="/reportuserexplanation.do", method=RequestMethod.GET)
		 * public String reportUserExplanation(Model model) { return
		 * "/WEB-INF/view/manager/report/ReportUserExplanation.jsp"; }
		 */
		
		@RequestMapping(value="/userlist.do", method=RequestMethod.GET)
		public String userList(Model model, @RequestParam(value="userId", required = false) String userId)
		{
			IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);

			if(userId != null)
			{
				model.addAttribute("userList", userDAO.searchUserListForManager(userId));
				model.addAttribute("searchId", userId);
			}
			else
			{				
				model.addAttribute("userList", userDAO.userListForManager());
			}
			
			return "/WEB-INF/view/manager/user/UserList.jsp";
		}
		
		@RequestMapping(value="/userdetail.do", method=RequestMethod.GET)
		public String userDetail(Model model, @RequestParam("userCode") String userCode)
		{
			IGroupJoinDAO groupJoinDAO = sqlSession.getMapper(IGroupJoinDAO.class);
			IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
			IReportDAO reportDAO = sqlSession.getMapper(IReportDAO.class);
			IInquiryDAO inquiryDAO = sqlSession.getMapper(IInquiryDAO.class);
			
			model.addAttribute("groupList", groupJoinDAO.groupListForManager(userCode));
			model.addAttribute("userInfo", userDAO.userInfoForManager(userCode));
			model.addAttribute("reportedList", reportDAO.reportedListForManager(userCode));
			model.addAttribute("reportList", reportDAO.reportListForManager(userCode));
			model.addAttribute("inquiryList", inquiryDAO.inquiryListForManager(userCode));
			model.addAttribute("loginLogList", userDAO.loginLogListForManager(userCode));
			
			
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
