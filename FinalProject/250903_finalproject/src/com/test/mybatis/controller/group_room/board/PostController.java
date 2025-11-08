package com.test.mybatis.controller.group_room.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IGroupPostDAO;
import com.test.mybatis.dto.GroupPostDTO;
import com.test.mybatis.dto.UserDTO;
import com.test.util.Paging;

@Controller
public class PostController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 전체 리스트 가져오기
	@RequestMapping(value="/postlist.do", method=RequestMethod.GET)
	public String postList(String groupApplyCode, HttpServletRequest request, Model model, String pageNum)
	{
		// sqlSession 가져오기
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		 

		// 페이지 번호 초기화
		int currentPage = 1;	// 기본값
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		// 전체 데이터 개수 구하기
		int dataCount = dao.listCount(groupApplyCode);
		int numPerPage = 10;	// 한 페이지에 표시할 데이터 개수
		
		Paging paging = new Paging();
		int totalPage = paging.getPageCount(numPerPage, dataCount);
		
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
			
		// url 생성
		String cp = request.getContextPath();
		String listUrl = cp + "/postlist.do?groupApplyCode=" + groupApplyCode;
		String pageIndexList = paging.pageIndexList(currentPage, totalPage, listUrl);
		
		// model에 데이터 담기
		model.addAttribute("list", dao.list(groupApplyCode, start, end));
		model.addAttribute("noticeList", dao.noticeList(groupApplyCode));
		model.addAttribute("pageIndexList", pageIndexList);
		model.addAttribute("start", start);
		
		// 주소 구성
		String articleUrl = "/WEB-INF/view/group_room/board/PostList.jsp";
		articleUrl += "?pageNum=" + currentPage;
		
		return articleUrl;
	}
	
	// 특정 게시글 조회하기
	@RequestMapping(value="/postdetail.do", method=RequestMethod.GET)
	public String showPostDetail(String postCode, Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("user");
		String groupApplyCode = (String)session.getAttribute("groupApplyCode");
		
		// 로그인 하지 않은 회원 거르기 완
		if (user != null && groupApplyCode != null) 
	    {
	        IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
	        String joinCode = dao.getJoinCode(groupApplyCode, user.getUserCode());
	        
	        // 모임에 가입하지 않은 회원 거르기 완
	        if (joinCode != null)
			{
	    		model.addAttribute("post", dao.postDetail(postCode));
	    		model.addAttribute("commentList", dao.commentList(postCode));
	    		
	    		return "/WEB-INF/view/group_room/board/PostDetail.jsp";
			}
	        else
	        {
	        	model.addAttribute("error", "게시글을 조회하려면 모임에 가입해야 합니다.");
		    	model.addAttribute("url", "postlist.do?groupApplyCode=" + groupApplyCode);
		    	return "redirect:/errorpage.do";
	        }
	    } 
	    else 
	    {
	    	model.addAttribute("error", "게시글을 조회하려면 모임에 가입해야 합니다.");
	    	model.addAttribute("url", "postlist.do?groupApplyCode=" + groupApplyCode);
	    	return "redirect:/errorpage.do";
	    }
		
	}

	// 검색리스트 불러오기
	@RequestMapping(value="/searchpost.do", method=RequestMethod.GET)
	public String searchPost(@RequestParam("searchType") String searchType 
			, @RequestParam("searchKeyword") String searchKeyword, String pageNum
			, Model model, String groupApplyCode)
	{
		// sqlSession 가져오기
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);

		// 페이지 번호 초기화
		int currentPage = 1;	// 기본값
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		// 전체 데이터 개수 구하기
		int dataCount = dao.searchListCount(groupApplyCode, searchType, searchKeyword);
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
		model.addAttribute("list", dao.searchList(groupApplyCode, searchType, searchKeyword, start, end));
		model.addAttribute("noticeList", dao.noticeList(groupApplyCode));
		model.addAttribute("pageIndexList", pageIndexList);
		System.out.println(searchKeyword);
		System.out.println(searchType);
		System.out.println(start);
		System.out.println(end);
		
		// 주소 구성
		String articleUrl = "/WEB-INF/view/group_room/board/PostList.jsp";
		articleUrl += "?pageNum=" + currentPage + param;
		
		return articleUrl;
	}

	// 게시글 작성 페이지로 이동
	@RequestMapping(value="/postwrite.do", method=RequestMethod.GET)
	public String writePost(Model model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();

	    UserDTO user = (UserDTO)session.getAttribute("user");
	    String groupApplyCode = (String)session.getAttribute("groupApplyCode");

	    if (user != null && groupApplyCode != null) 
	    {
	        IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
	        String joinCode = dao.getJoinCode(groupApplyCode, user.getUserCode());
	        
	        if (joinCode != null)
			{
	        	model.addAttribute("position", dao.validateMember(joinCode));
	        	model.addAttribute("joinCode", joinCode);
	        	model.addAttribute("groupApplyCode", groupApplyCode);
	        	return "/WEB-INF/view/group_room/board/WritePost.jsp";
			}
	        else
	        {
	        	model.addAttribute("error", "게시글을 작성하려면 모임에 가입해야 합니다.");
	        	model.addAttribute("url", "postlist.do?groupApplyCode=" + groupApplyCode);
	        	return "redirect:/errorpage.do";
	        }
	    } 
	    else 
	    {
	    	model.addAttribute("error", "게시글을 작성하려면 모임에 가입해야 합니다.");
	    	model.addAttribute("url", "postlist.do?groupApplyCode=" + groupApplyCode);
	    	return "redirect:/errorpage.do";
	    }
		
	}
	
	// 게시글 작성 기능
	@RequestMapping(value="/postwriteOk.do", method=RequestMethod.GET)
	public String writePostOk(HttpServletRequest request, Model model, HttpSession session)
	{
		String subject = request.getParameter("subject");
		String content = request.getParameter("content").replaceAll("\n", "<br>");
		String boardCategory = getBoardCategory(request.getParameter("boardCategory"));
		String joinCode = request.getParameter("joinCode");
		String savePath = "";
		
		GroupPostDTO dto = new GroupPostDTO();
		dto.setBoardCategory(boardCategory);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setJoinCode(joinCode);
		dto.setSavePath(savePath);
		
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		dao.insertPost(dto);
		
		HttpSession session1 = request.getSession();
		String groupApplyCode = (String)session1.getAttribute("groupApplyCode");
		
		return "redirect:postlist.do?groupApplyCode=" + groupApplyCode;
	}
	
	// 게시글 수정 페이지로 이동
	@RequestMapping(value="/postedit.do", method=RequestMethod.GET)
	public String editPost(Model model, String postCode, HttpServletRequest request)
	{
		// 본인인지 또는 도우미인지 체크
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("user");
		String groupApplyCode = (String)session.getAttribute("groupApplyCode");
		
		// 로그인 하지 않은 회원 거르기 완
		if (user != null && groupApplyCode != null) 
	    {
	        IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
	        String joinCode = dao.getJoinCode(groupApplyCode, user.getUserCode());
	        
	        // 모임에 가입하지 않은 회원 거르기 완
	        if (joinCode != null)
			{
	        	GroupPostDTO dto =  dao.postDetail(postCode);
	        	String author = dto.getJoinCode();
	        	System.out.println(author);
	        	String authority = dao.validateMember(joinCode);
	        	System.out.println(authority);
	        	
	        	// 작성자가 아니고 권한 없는 사람 거르기 완
	        	if (author == joinCode || authority != "도우미"
	        		|| authority != "부모임장" || authority != "모임장")
				{
	        		dto.setContent(dto.getContent().replace("<br>", "\n"));
	        		model.addAttribute("post", dto);
	        		return "/WEB-INF/view/group_room/board/EditPost.jsp";
				}
	        	else
	        	{
	        		model.addAttribute("error", "수정할 권한이 없습니다.");
	        		model.addAttribute("url", "postdetail.do?postCode=" + postCode);
	        		return "redirect:/errorpage.do";
	        	}
			}
	        else
	        {
	        	model.addAttribute("error", "잘못된 접근입니다.");
		    	model.addAttribute("url", "loginpage.do");
		    	return "redirect:/errorpage.do";
	        }
	    } 
	    else 
	    {
	    	model.addAttribute("error", "잘못된 접근입니다.");
	    	model.addAttribute("url", "loginpage.do");
	    	return "redirect:/errorpage.do";
	    }
	}
	
	// 게시글 수정 기능
	@RequestMapping(value="/posteditOk.do", method=RequestMethod.GET)
	public String editPostOk(HttpServletRequest request, Model model)
	{
		String postCode = request.getParameter("postCode");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content").replaceAll("\n", "<br>");
		String boardCategory = getBoardCategory(request.getParameter("boardCategory"));
		System.out.println(boardCategory);
		String savePath = "";
		
		GroupPostDTO dto = new GroupPostDTO();
		dto.setPostCode(postCode);
		dto.setBoardCategory(boardCategory);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setSavePath(savePath);
		
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		dao.updatePost(dto);
		
		return "redirect:postlist.do";
	}
	
	// 게시글 삭제 기능
	@RequestMapping(value="/postdeleteOk.do", method=RequestMethod.GET)
	public String deletePostOk(String postCode, Model model)
	{
		// 본인인지 또는 도우미인지 체크
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		dao.deletePost(postCode);
		
		return "redirect:postlist.do";
	}

	// 카테고리 스트링에서 db타입에 맞춰 변환
	private String getBoardCategory(String boardCategory)
	{
	    if (boardCategory == null) {
	        return "0";
	    }
	    
	    switch (boardCategory) {
        case "notice":
            return "1";
        case "activity":
            return "2";
        case "question":
            return "3";
        case "resource":
            return "4";
        case "free":
            return "5";
        default:
            return "0";
	    }
	}
	
	public String insertComment()
	{
		String result = "";
		return null;
	}
	
	public String updateComment()
	{
		String result = "";
		return null;
	}
	
	public String deleteComment()
	{
		String result = "";
		return null;
	}
}
