package com.test.mybatis.controller.group_room.board;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IGroupPostDAO;
import com.test.util.Paging;

@Controller
public class PostController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/postlist.do", method=RequestMethod.GET)
	public String postList(HttpServletRequest request, Model model, String pageNum)
	{
		// sqlSession 가져오기
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		 

		// 페이지 번호 초기화
		int currentPage = 1;	// 기본값
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		// 전체 데이터 개수 구하기
		int dataCount = dao.listCount();
		int numPerPage = 10;	// 한 페이지에 표시할 데이터 개수
		
		Paging paging = new Paging();
		int totalPage = paging.getPageCount(numPerPage, dataCount);
		
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
			
		// url 생성
		String cp = request.getContextPath();
		String listUrl = cp + "/postlist.do";
		String pageIndexList = paging.pageIndexList(currentPage, totalPage, listUrl);
		
		// model에 데이터 담기
		model.addAttribute("list", dao.list(start, end));
		model.addAttribute("noticeList", dao.noticeList());
		model.addAttribute("pageIndexList", pageIndexList);
		model.addAttribute("start", start);
		
		// 주소 구성
		String articleUrl = "/WEB-INF/view/group_room/board/PostList.jsp";
		articleUrl += "?pageNum=" + currentPage;
		
		return articleUrl;
	}
	
	@RequestMapping(value="/postdetail.do", method=RequestMethod.GET)
	public String showPostDetail(String postCode, Model model)
	{
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		
		model.addAttribute("post", dao.postDetail(postCode));
		model.addAttribute("commentList", dao.commentList(postCode));
		
		return "/WEB-INF/view/group_room/board/PostDetail.jsp";
	}

	@RequestMapping(value="/searchpost.do", method=RequestMethod.GET)
	public String searchPost(@RequestParam("searchType") String searchType 
			, @RequestParam("searchKeyword") String searchKeyword, String pageNum
			, Model model)
	{
		// sqlSession 가져오기
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);

		// 페이지 번호 초기화
		int currentPage = 1;	// 기본값
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		// 전체 데이터 개수 구하기
		int dataCount = dao.listCount();
		int numPerPage = 10;	// 한 페이지에 표시할 데이터 개수
		
		Paging paging = new Paging();
		int totalPage = paging.getPageCount(numPerPage, dataCount);
		
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
			
		// url 생성
		String listUrl = "/postlist.do";
		String pageIndexList = paging.pageIndexList(currentPage, totalPage, listUrl);
		
		String param = "";
		if(!searchType.equals("") && !searchKeyword.equals("")
			&& searchType != null && searchKeyword != null)
		{
			param += "&searchKeyword=" + searchKeyword;
			param += "&searchType=" + searchType;
		}
		
		// model에 데이터 담기
		model.addAttribute("list", dao.list(start, end));
		model.addAttribute("noticeList", dao.noticeList());
		model.addAttribute("pageIndexList", pageIndexList);
		
		// 주소 구성
		String articleUrl = "/WEB-INF/view/group_room/board/PostList.jsp";
		articleUrl += "?pageNum=" + currentPage;
		
		return articleUrl;
	}

	@RequestMapping(value="/postwrite.do", method=RequestMethod.GET)
	public String writePost(Model model)
	{
		return "/WEB-INF/view/group_room/board/WritePost.jsp";
	}
	
	@RequestMapping(value="/postedit.do", method=RequestMethod.GET)
	public String editPost(Model model)
	{
		return "/WEB-INF/view/group_room/board/EditPost.jsp";
	}
	
}
