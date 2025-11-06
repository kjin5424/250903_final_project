package com.test.mybatis.controller.group_room;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.oreilly.servlet.MultipartRequest;
import com.test.mybatis.dao.IActivityDAO;
import com.test.mybatis.dao.IChallengeDAO;
import com.test.mybatis.dao.IGroupDAO;
import com.test.mybatis.dao.IGroupJoinDAO;
import com.test.mybatis.dto.ActivityDTO;
import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.GroupJoinDTO;
import com.test.mybatis.dto.UserDTO;
import com.test.util.Paging;


@Controller
public class HomeController
{
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/home.do", method=RequestMethod.GET)
	public String home(Model model, HttpSession session, String groupApplyCode)
	{
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		IChallengeDAO cDao = sqlSession.getMapper(IChallengeDAO.class);
		IGroupJoinDAO joinDao = sqlSession.getMapper(IGroupJoinDAO.class);
		
		UserDTO user = (UserDTO)session.getAttribute("user");
		String userCode;
		if(user==null)
			userCode = "user";
		else
			userCode = user.getUserCode();
		
		model.addAttribute("groupInfo",dao.groupHomeGroupInfo(userCode, groupApplyCode));
		model.addAttribute("activity", sqlSession.selectList("com.test.mybatis.dao.IActivityDAO.activityListAtHome", groupApplyCode));
		model.addAttribute("post", sqlSession.selectList("com.test.mybatis.dao.IGroupPostDAO.postListAtHome", groupApplyCode));
		model.addAttribute("checkMember", dao.checkMember(groupApplyCode, userCode));
		model.addAttribute("challenge", cDao.challengeAtHome(groupApplyCode, userCode));
		model.addAttribute("selfIntro", joinDao.getSelfIntro(groupApplyCode, userCode));
		
		return "/WEB-INF/view/group_room/Home.jsp";
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
	public String votelist(HttpServletRequest request, Model model, @RequestParam("groupApplyCode") String groupApplyCode, String pageNum)
	{
		IActivityDAO dao = sqlSession.getMapper(IActivityDAO.class);
		
		ActivityDTO activityDTO = new ActivityDTO();
		
		int currentPage = 1;	// 기본값
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		// 전체 데이터 개수 구하기
		int dataCount = dao.countActivity(groupApplyCode);
		int numPerPage = 10;	// 한 페이지에 표시할 데이터 개수
		
		Paging paging = new Paging();
		int totalPage = paging.getPageCount(numPerPage, dataCount);
		
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
			
		// url 생성
		String cp = request.getContextPath();
		String listUrl = cp + "/votelist.do";
		String pageIndexList = paging.pageIndexList(currentPage, totalPage, listUrl);
		
		// model에 데이터 담기
		model.addAttribute("pageIndexList", pageIndexList);
		model.addAttribute("start", start);
		
		activityDTO.setGroupApplyCode(groupApplyCode);
		activityDTO.setStart(start);
		activityDTO.setEnd(end);
		
		// 주소 구성
		String articleUrl = "/WEB-INF/view/group_room/vote/VoteList.jsp";
		articleUrl += "?pageNum=" + currentPage;
		
		model.addAttribute("activityList"
				, sqlSession.selectList("com.test.mybatis.dao.IActivityDAO.activityForGroup", activityDTO));
		
		
		return articleUrl;
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
	
	@RequestMapping(value="/groupcreate.do", method=RequestMethod.GET)
	public String groupCreate(Model model, HttpSession session)
	{
		UserDTO user = (UserDTO)session.getAttribute("user");
		if(user==null)
			return "redirect:loginpage.do";
		
		return "/WEB-INF/view/group/GroupCreate.jsp";
	}
	

	@Transactional
	@RequestMapping(value="/groupcreatecomplete.do", method= RequestMethod.GET)
	public String groupCreateComplete(HttpServletRequest request, HttpSession session)
	{
		try
		{
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		UserDTO user = (UserDTO)session.getAttribute("user");
		if(user==null)
			return "redirect:loginpage.do";
		
		//MultipartRequest multi = null;
		//multi = new MultipartRequest(요청객체, 저장경로, 최대업로드크기, 인코딩방식, 파일명정책);
		//multi = new MultipartRequest(request, savePath, maxFileSize, encType, new DefaultFileRenamePolicy());
				
		
		GroupDTO dto = new GroupDTO();
	    dto.setProposerCode(user.getUserCode());
	    System.out.println("userCode : " + user.getUserCode());
	    
	    dto.setOnOffType(Integer.parseInt((request.getParameter("onOffType"))));
	    System.out.println("onOff : " + request.getParameter("onOffType"));
	    
	    dto.setFrequencyType(Integer.parseInt(request.getParameter("frequencyType")));
	    System.out.println("frequency : " + request.getParameter("frequencyType"));
	    
	    dto.setDifficultyType(Integer.parseInt(request.getParameter("difficultyType")));
	    System.out.println("difficulty : " + request.getParameter("difficultyType"));
	    
	    dto.setGroupTitle(request.getParameter("groupTitle"));
	    System.out.println("groupTitle : " + request.getParameter("groupTitle"));
	    
	    dto.setGroupContent(request.getParameter("groupContent"));
	    System.out.println("groupContent : " + request.getParameter("groupContent"));
	    
	    dto.setTopicType(Integer.parseInt(request.getParameter("topicType")));
	    System.out.println("topic : " + request.getParameter("topicType"));
	    
	    dto.setYouthFriendlyType(Integer.parseInt(request.getParameter("youthFriendlyType")));
	    System.out.println("youth : " + request.getParameter("youthFriendlyType"));
	    
	    dto.setGenderType(Integer.parseInt(request.getParameter("genderType")));
	    System.out.println("gender : " + request.getParameter("genderType"));
	    
	    dto.setQuestion(request.getParameter("question"));
	    System.out.println("question : " + request.getParameter("question"));
	    
	    dto.setRule(request.getParameter("rule"));
	    System.out.println("rule : " + request.getParameter("rule"));
	    
	    dto.setKickOut(Integer.parseInt(request.getParameter("kickOut")));
	    System.out.println("kickOut : " + request.getParameter("kickOut"));
	    
	    dto.setPassword(request.getParameter("password"));
	    System.out.println("pw : " + request.getParameter("password"));
	    
	    dto.setRegion(request.getParameter("region") + request.getParameter("postcode"));
	    System.out.println("region : " + request.getParameter("region") + request.getParameter("postcode"));
	    sqlSession.insert("com.test.mybatis.dao.IGroupDAO.groupApply", dto);
		
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "/WEB-INF/view/group/GroupCreateComplete.jsp";
	}
	
	
	@RequestMapping(value="/applicant.do", method=RequestMethod.GET)
	public String applicant(String groupApplyCode, Model model)
	{
		IGroupJoinDAO dao = sqlSession.getMapper(IGroupJoinDAO.class);
		List<GroupJoinDTO> applicantList = dao.selectGroupJoinById(groupApplyCode);
		
		model.addAttribute("applicant", applicantList);
		
		
		
		return "/WEB-INF/view/group_room/manage/Applicant.jsp";
	}
	
	@RequestMapping(value="/attendance.do", method=RequestMethod.GET)
	public String attendance(Model model)
	{
		return "/WEB-INF/view/group_room/manage/Attendance.jsp";
	}
	
	
	
}






























