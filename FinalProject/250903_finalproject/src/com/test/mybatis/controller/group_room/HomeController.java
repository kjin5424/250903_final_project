package com.test.mybatis.controller.group_room;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/home.do", method=RequestMethod.GET)
	public String home(Model model)
	{
		return "/WEB-INF/view/group_room/Home.jsp";
	}
	
	@RequestMapping(value="/postlist.do", method=RequestMethod.GET)
	public String postList(Model model)
	{
		return "/WEB-INF/view/group_room/board/PostList.jsp";
	}
	
	@RequestMapping(value="/challengelist.do", method=RequestMethod.GET)
	public String challengeList(Model model)
	{
		return "/WEB-INF/view/group_room/challenge/ChallengeList.jsp";
	}
	
	@RequestMapping(value="/history.do", method=RequestMethod.GET)
	public String histroy(Model model)
	{
		return "/WEB-INF/view/group_room/Histroy.jsp";
	}
	
	@RequestMapping(value="/memberlist.do", method=RequestMethod.GET)
	public String memberList(Model model)
	{
		return "/WEB-INF/view/group_room/MemberList.jsp";
	}
	@RequestMapping(value="/messagelist.do", method=RequestMethod.GET)
	public String messagelist(Model model)
	{
		return "/WEB-INF/view/group_room/MessageList.jsp";
	}
	
	@RequestMapping(value="/managelist.do", method=RequestMethod.GET)
	public String manageList(Model model)
	{
		return "/WEB-INF/view/group_room/manage/ManageList.jsp";
	}
	@RequestMapping(value="/votelist.do", method=RequestMethod.GET)
	public String votelist(Model model)
	{
		return "/WEB-INF/view/group_room/vote/VoteList.jsp";
	}
	
	@RequestMapping(value="/level.do", method=RequestMethod.GET)
	public String level(Model model)
	{
		return "/WEB-INF/view/group_room/Level.jsp";
	}
	@RequestMapping(value="/reportgroup.do", method=RequestMethod.GET)
	public String reportGroup(Model model)
	{
		return "/WEB-INF/view/report/ReportGroup.jsp";
	}
	
	@RequestMapping(value="/reportcontent.do", method=RequestMethod.GET)
	public String reportContent(Model model)
	{
		return "/WEB-INF/view/report/ReportContent.jsp";
	}
	
	@RequestMapping(value="/reportafter.do", method=RequestMethod.GET)
	public String reportAfter(Model model)
	{
		return "/WEB-INF/view/report/ReportAfter.jsp";
	}
	
	@RequestMapping(value="/membermanage.do", method=RequestMethod.GET)
	public String memberManage(Model model)
	{
		return "/WEB-INF/view/group_room/manage/MemberManage.jsp";
	}
	
	@RequestMapping(value="/applicant.do", method=RequestMethod.GET)
	public String applicant(Model model)
	{
		return "/WEB-INF/view/group_room/manage/Applicant.jsp";
	}
	
	@RequestMapping(value="/attendance.do", method=RequestMethod.GET)
	public String attendance(Model model)
	{
		return "/WEB-INF/view/group_room/manage/Attendance.jsp";
	}
	
	@RequestMapping(value="/writepost.do", method=RequestMethod.GET)
	public String writePost(Model model)
	{
		return "/WEB-INF/view/group_room/board/WritePost.jsp";
	}
	
	@RequestMapping(value="/postdetail.do", method=RequestMethod.GET)
	public String announcement(Model model)
	{
		return "/WEB-INF/view/group_room/board/PostDetail.jsp";
	}
	
	@RequestMapping(value="/editpost.do", method=RequestMethod.GET)
	public String editPost(Model model)
	{
		return "/WEB-INF/view/group_room/board/EditPost.jsp";
	}
	
	
}






























