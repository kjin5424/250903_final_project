package com.test.mybatis.controller.group_room.vote;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IActivityDAO;
import com.test.mybatis.dao.IUserDAO;
import com.test.mybatis.dto.ActivityDTO;
import com.test.mybatis.dto.UserDTO;
import com.test.util.Paging;

@Controller
public class VoteController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 특정 모임코드를 매개변수로 받아 활동 리스트를 한 페이지 당 10개 씩 보여주는 메소드
	@RequestMapping(value="/votelist.do", method=RequestMethod.GET)
	public String votelist(HttpServletRequest request, Model model, @RequestParam("groupApplyCode") String groupApplyCode, String pageNum, @RequestParam(required=false) Integer errorType)
	{
		IActivityDAO dao = sqlSession.getMapper(IActivityDAO.class);
		
		ActivityDTO activityDTO = new ActivityDTO();
		
		int currentPage = 1;	// 기본값
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		if(errorType!=null)
		{
			model.addAttribute("errorType", errorType);
		}
		
		// 전체 데이터 개수 구하기
		Integer dataCountInteger = dao.countActivity(groupApplyCode);
		int dataCount = 1;

		if(dataCountInteger!=null)
		{
			dataCount = (int)dataCountInteger;
		}
		
		
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
		model.addAttribute("groupApplyCode", groupApplyCode);
		
		activityDTO.setGroupApplyCode(groupApplyCode);
		activityDTO.setStart(start);
		activityDTO.setEnd(end);
		
		// 주소 구성
		String articleUrl = "/WEB-INF/view/group_room/vote/VoteList.jsp";
		articleUrl += "?pageNum=" + currentPage;
		
		model.addAttribute("activityList"
				, sqlSession.selectList("com.test.mybatis.dao.IActivityDAO.activityForGroup", activityDTO));
		
		
		return articleUrl;
	}//close voteList()
	

	// 특정 모임의 활동을 등록하려 할 때 나가는 메소드
	@RequestMapping(value="/votecreate.do", method=RequestMethod.GET)
	public String createVote(HttpServletRequest request, HttpSession session, @RequestParam("groupApplyCode") String groupApplyCode)
	{
		String url = "/WEB-INF/view/group_room/vote/VoteCreate.jsp";
		
		UserDTO user = (UserDTO)session.getAttribute("user");
		
		// 로그인을 안했을 때
		if(user==null)
		{
			int errorType= 1;
			// 로그인부터 말끔히 진행된다면 세션으로 접속 상태를 구분할 수 있기 때문에 추후에 주석 제거
			//return "redirect:votelist.do?groupApplyCode=" + groupApplyCode + "&errorType=" + errorType;
		}
		
		// 로그인부터 말끔히 진행된다면 세션으로 접속 상태를 구분할 수 있기 때문에 추후에 주석 제거
		//String userCode = user.getUserCode();
		
		IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
		
		// 로그인부터 말끔히 진행된다면 세션으로 접속 상태를 구분할 수 있기 때문에 추후에 주석 제거
		//String joinCode = userDAO.checkMember(userCode, groupApplyCode);
		
		// 로그인부터 말끔히 진행된다면 세션으로 접속 상태를 구분할 수 있기 때문에 추후에 주석 제거
		// 로그인은 했는데 해당 모임의 모임원이 아닐 때
		//if(joinCode==null)
		{
			int errorType= 2;
			// 로그인부터 말끔히 진행된다면 세션으로 접속 상태를 구분할 수 있기 때문에 추후에 주석 제거
			//return "redirect:votelist.do?groupApplyCode=" + groupApplyCode + "&errorType=" + errorType;
		}
		
		request.setAttribute("joinCode", "228");
		request.setAttribute("groupApplyCode", groupApplyCode);
		
		return url;
	}//close createVote()
	
	// 특정 모임의 활동이 등록되는 메소드 → 사용자 안만남
	@RequestMapping(value="/voteinsert.do", method = RequestMethod.GET)
	public String insertActivity(HttpServletRequest request, @RequestParam("groupApplyCode") String groupApplyCode) throws UnsupportedEncodingException
	{
		String url = "redirect:votelist.do?groupApplyCode=" + groupApplyCode;
		
		IActivityDAO dao = sqlSession.getMapper(IActivityDAO.class);
		
		ActivityDTO dto = new ActivityDTO();
		
		dto.setActiveDate(request.getParameter("date") + " " + request.getParameter("start-time"));
		dto.setJoinCode(request.getParameter("joinCode"));
		dto.setContent(request.getParameter("content"));
		dto.setTime(request.getParameter("progress-time"));
		
		if(request.getParameter("on_off").equals("offline"))
		{
			dto.setPlace(request.getParameter("location"));
			dto.setOnOffLine("2");
		}
		else
		{
			dto.setPlace(request.getParameter("uri"));
			dto.setOnOffLine("1");
		}
		
		dao.addActivity(dto);
		
		return url;
	}
	
}
