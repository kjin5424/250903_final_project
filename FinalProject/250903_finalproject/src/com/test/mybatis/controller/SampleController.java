package com.test.mybatis.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IGroupDAO;
import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.SearchDTO;
import com.test.mybatis.dto.UserDTO;

/* ========================
	SampleController.java
	- 컨트롤러
======================== */

@Controller
public class SampleController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 임시 메인 페이지 임시 구동
	@RequestMapping(value="/mainpage.do")
	public String testMain(Model model, String category)
	{
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		String topicType;
		
		HashMap<String, String> categoryMap = new HashMap<String, String>();
		// category로 들어온 문자형 topicType에 맞도록 매핑
		categoryMap.put("reading", "1");
		categoryMap.put("language", "2");
		categoryMap.put("it", "3");
		categoryMap.put("startup", "4");
		categoryMap.put("license", "5");
		categoryMap.put("exam", "6");
		categoryMap.put("hobby", "7");
		categoryMap.put("etc", "8");
		
		try
		{
			// category null 이거나 all일 경우
			if ("".equals(category) || category == null || "all".equals(category))
			{
				topicType = "%";
				
				// 전체 그룹 리스트 출력
				ArrayList<GroupDTO> groupListAll = dao.groupList(topicType);
				
				// 리스트 요소 섞기
				Collections.shuffle(groupListAll);
				
				// 전체 중 10개만 뽑기(groupList에 덮어쓰기)
				List<GroupDTO> groupList = groupListAll.subList(0, Math.min(10, groupListAll.size()));
	
				// 현재 인원 수 구하는 코드
				for (GroupDTO dto : groupList)
				{
					String groupApplyCode = dto.getGroupApplyCode();
					dto.setCurrentMemberCount(dao.groupMemberCount(groupApplyCode));
				}
				model.addAttribute("groupList", groupList);
				
				// 랜덤 카테고리 그룹 리스트 출력
				Random rd = new Random();
				String rdNum = String.valueOf(rd.nextInt(8)+1);
				ArrayList<GroupDTO> groupRandomList = dao.groupList(rdNum);
				
				Collections.shuffle(groupRandomList);
				
				for (GroupDTO dto : groupRandomList)
				{
					String groupApplyCode = dto.getGroupApplyCode();
					dto.setCurrentMemberCount(dao.groupMemberCount(groupApplyCode));
				}
				model.addAttribute("groupRandomList", groupRandomList);
				
				// 카테고리 이름 찍어주기 용
				model.addAttribute("categoryNum", rdNum);
			}
			else	// 특정 카테고리가 들어온 경우
			{
				// topicType → 문자타입 숫자형 (reading → 1) 
				topicType = categoryMap.get(category);
				
				ArrayList<GroupDTO> groupList = dao.groupList(topicType);
				Collections.shuffle(groupList);
				for (GroupDTO dto : groupList)
				{
					String groupApplyCode = dto.getGroupApplyCode();
					dto.setCurrentMemberCount(dao.groupMemberCount(groupApplyCode));
				}
				model.addAttribute("groupList", groupList);
				// 카테고리 이름 찍어주기 용
				model.addAttribute("categoryNum", topicType);
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "/WEB-INF/view/group/GroupList.jsp";
	}
	
	
	// 임시 검색 페이지 구동
	@RequestMapping(value="/search.do", method=RequestMethod.POST)
	public String testSearch( Model model, String content
		  , @RequestParam(value = "category", required = false) List<String> category
		  , @RequestParam(value = "region", required = false) List<String> region
		  , @RequestParam(value = "type", required = false) List<String> type
		  , @RequestParam(value = "status", required = false) List<String> status )
	{
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		SearchDTO filter = new SearchDTO();
		SearchDTO tempFilter = new SearchDTO();
		
		
		HashMap<String, String> categoryMap = new HashMap<String, String>();
		categoryMap.put("독서", "1");
		categoryMap.put("어학", "2");
		categoryMap.put("IT", "3");
		categoryMap.put("창업·취업", "4");
		categoryMap.put("자격증", "5");
		categoryMap.put("시험", "6");
		categoryMap.put("취미", "7");
		categoryMap.put("기타", "8");
		
		HashMap<String, String> typeMap = new HashMap<String, String>();
		typeMap.put("온라인", "1");
		typeMap.put("오프라인", "2");
		typeMap.put("복합", "3");
		
		HashMap<String, String> statusMap = new HashMap<String, String>();
		statusMap.put("신규개설", "GA.CREATED_DATE + 7 > SYSDATE");
		statusMap.put("진행중", "GA.OPEN_DATE IS NOT NULL");
		
		try
		{
			if (content != null || "".contentEquals(content))
			{
				filter.setContent(content);
				tempFilter.setContent(content);
			}
			if (category != null)
			{
				List<String> temp = new ArrayList<String>();
				filter.setCategory(category);
				for(String key : category)
					temp.add(categoryMap.get(key));
				tempFilter.setCategory(temp);
			}
			if (region != null)
			{
				filter.setRegion(region);
				tempFilter.setRegion(region);
			}
			if (type != null)
			{
				filter.setType(type);
				List<String> temp = new ArrayList<String>();
				for(String key : type)
					temp.add(typeMap.get(key));
				tempFilter.setType(temp);
			}
			if (status != null)
			{
				filter.setStatus(status);
				List<String> temp = new ArrayList<String>();
				for(String key : status)
					temp.add(statusMap.get(key));
				tempFilter.setStatus(temp);
			}
			
			ArrayList<GroupDTO> groupList = dao.searchList(tempFilter);
			for (GroupDTO dto : groupList)
				dto.setCurrentMemberCount(dao.groupMemberCount(dto.getGroupApplyCode()));
			
			model.addAttribute("groupList", groupList);
			model.addAttribute("filter", filter);
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "/WEB-INF/view/group/SearchList.jsp";
	}
	
	
	// 자격 검증용 코드
	public String testUser(HttpSession session)
	{
		UserDTO user = (UserDTO)session.getAttribute("user");
		if (user == null)
		{
			// 회원 정보 없음
		}
		else
		{
			// 회원 정보 있음
			// 기본적으로 nickName, userCode 존재.
			// 추후 추가할 경우 다룰 때 주의.
		}
		
		return "";
	}
	
	
	@RequestMapping(value="/sample.action", method=RequestMethod.GET)
	public String sample(Model model)
	{
		return "/WEB-INF/view/Sample.jsp";
	}
}
