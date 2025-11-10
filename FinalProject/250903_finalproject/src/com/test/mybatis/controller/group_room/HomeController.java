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
import com.test.mybatis.dao.IHistoryDAO;
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
		String userCode = "UC00000010";
		if(user!=null)
			userCode = user.getUserCode();
		
		session.setAttribute("groupApplyCode", groupApplyCode);
		
		model.addAttribute("groupInfo",dao.groupHomeGroupInfo(userCode, groupApplyCode));
		model.addAttribute("activity", sqlSession.selectList("com.test.mybatis.dao.IActivityDAO.activityListAtHome", groupApplyCode));
		model.addAttribute("post", sqlSession.selectList("com.test.mybatis.dao.IGroupPostDAO.postListAtHome", groupApplyCode));
		model.addAttribute("checkMember", dao.checkMember(groupApplyCode, userCode));
		model.addAttribute("challenge", cDao.challengeAtHome(groupApplyCode, userCode));
		model.addAttribute("selfIntro", joinDao.getSelfIntro(groupApplyCode, userCode));
		
		return "/WEB-INF/view/group_room/Home.jsp";
	}

	// 히스토리 페이지
	@RequestMapping(value="/history.do", method=RequestMethod.GET)
	public String histroy(Model model, @RequestParam("groupApplyCode") String groupApplyCode)
	{
		IGroupDAO groupDao = sqlSession.getMapper(IGroupDAO.class);
		IHistoryDAO historyDao = sqlSession.getMapper(IHistoryDAO.class);
		
		String groupLevel = "1";
		if(!historyDao.currentLevel(groupApplyCode).equals("-1"))
			groupLevel = historyDao.currentLevel(groupApplyCode);

		Integer countActivity = historyDao.countActivity(groupApplyCode);
		if(countActivity==null)
			countActivity = 0;
		
		Integer countChallenge = historyDao.countChallenge(groupApplyCode);
		if(countChallenge==null)
			countChallenge = 0;
		
		model.addAttribute("history", sqlSession.selectList("com.test.mybatis.dao.IHistoryDAO.getHistory", groupApplyCode));
		model.addAttribute("notLevelHistory", sqlSession.selectList("com.test.mybatis.dao.IHistoryDAO.notLevelHistory", groupApplyCode));
		model.addAttribute("levelHistory", sqlSession.selectList("com.test.mybatis.dao.IHistoryDAO.levelHistory", groupApplyCode));
		model.addAttribute("groupLevel", groupLevel);
		model.addAttribute("countChallenge", countChallenge);
		model.addAttribute("countActivity", countActivity);
		
		
		return "/WEB-INF/view/group_room/Histroy.jsp";
	}
	
	@RequestMapping(value="/memberlist.do", method=RequestMethod.GET)
	public String memberList(Model model)
	{
		return "/WEB-INF/view/group_room/MemberList.jsp";
	}
	
	@RequestMapping(value="/managelist.do", method=RequestMethod.GET)
	public String manageList(@RequestParam("groupApplyCode") String groupApplyCode, Model model)
	{
		 model.addAttribute("groupApplyCode", groupApplyCode);
		
		return "/WEB-INF/view/group_room/manage/ManageList.jsp";
	}
	
	@RequestMapping(value="/grouplistdetail.do", method=RequestMethod.GET)
	public String groupListDetail(@RequestParam("groupCode") String groupCode,
	                              Model model,
	                              HttpServletRequest request)
	{
	    IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
	    try {
	        GroupDTO groupDetail = dao.groupDetail(groupCode);
	        if (groupDetail == null) 
	        {
	            return "redirect:/mainpage.do";
	        }
	        List<GroupDTO> memberList = dao.groupUserList(groupCode);
	        if (!memberList.isEmpty()) {
	            String groupApplyCode = memberList.get(0).getGroupApplyCode();
	            int memberCount = dao.groupMemberCount(groupApplyCode);
	            groupDetail.setCurrentMemberCount(memberCount);
	           
	            Integer activityCount = dao.countActivity(groupApplyCode);
	            
	            // 활동수
	            model.addAttribute("activityCount", (activityCount == null) ? 0 : activityCount);
	        }
	        HttpSession session = request.getSession();
	        Boolean isAuthenticated = (Boolean) session.getAttribute("authenticatedGroup_" + groupCode);
	        if ((groupDetail.getPassword() != null && !groupDetail.getPassword().isEmpty())
	                && (isAuthenticated == null || !isAuthenticated)) {
	            model.addAttribute("groupTitle", groupDetail.getGroupTitle());
	            model.addAttribute("topic", groupDetail.getTopic());
	            return "/WEB-INF/view/group/CheckPassword.jsp";
	        }
	        model.addAttribute("groupDetail", groupDetail);
	        model.addAttribute("memberList", memberList);
	        return "/WEB-INF/view/group/GroupListDetail.jsp";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/mainpage.do";
	    }
	}

	// ① GET (비밀번호 입력 화면)
			@RequestMapping(value="/checkpassword.do", method=RequestMethod.GET)
			public String showPasswordPage(@RequestParam("groupCode") String groupCode,
			                               @RequestParam(value="error", required=false) String error,
			                               Model model) {
			    model.addAttribute("groupCode", groupCode);
			    model.addAttribute("error", error);
			    return "/WEB-INF/view/group/CheckPassword.jsp";
			}
		
			// ② POST (비밀번호 검증)
			@RequestMapping(value="/checkpassword.do", method=RequestMethod.POST)
			public String groupPassword(@RequestParam("groupCode") String groupCode, 
			                            @RequestParam("password") String password,
			                            HttpServletRequest request) {
			    IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
			    try {
			        String dbPassword = dao.groupPassword(groupCode);
			        System.out.println("==== 비밀번호 검증 ====");
			        System.out.println("Group Code: " + groupCode);
			        System.out.println("DB 비밀번호: [" + dbPassword + "]");
			        System.out.println("입력 비밀번호: [" + password + "]");
		
			        if (dbPassword != null && dbPassword.trim().equals(password.trim())) {
			        	
			        	HttpSession session = request.getSession();
			            session.setAttribute("authenticatedGroup_" + groupCode, true);

			        	
			            System.out.println("비밀번호 일치 -> 상세 페이지로 이동");
			            return "redirect:/grouplistdetail.do?groupCode=" + groupCode;
			        } else {
			            System.out.println("비밀번호 불일치 -> 다시 입력 페이지로");
			            return "redirect:/checkpassword.do?groupCode=" + groupCode + "&error=wrong";
			        }
		
			    } catch (Exception e) {
			        System.out.println("에러 발생: " + e.getMessage());
			        e.printStackTrace();
			        return  "redirect:/checkpassword.do?groupCode=" + groupCode + "&error=system";
			    }
			}

			@RequestMapping(value="/apply.do", method=RequestMethod.GET)
			public String groupApply(@RequestParam("groupCode") String groupCode, Model model)
			{
				
				
				IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);

			    try
			    {
			        // groupCode → groupApplyCode 로 변환 필요 시 dao에서 처리 가능
			        System.out.println("apply.do 진입 | groupCode = " + groupCode);

			        GroupDTO groupDetail = dao.groupDetail(groupCode);
			        GroupDTO groupQuestionRule = dao.groupQuestionRule(groupCode);
			   
			        
			        List<GroupDTO> memberList = dao.groupUserList(groupCode);
			        if (!memberList.isEmpty()) {
			            String groupApplyCode = memberList.get(0).getGroupApplyCode();
			            int memberCount = dao.groupMemberCount(groupApplyCode);
			            groupDetail.setCurrentMemberCount(memberCount);
			        }

			        if (groupDetail == null)
			        {
			            System.out.println("❌ 해당 코드의 모임이 없습니다.");
			            return "redirect:/mainpage.do";
			        }
			        
			        if (groupQuestionRule != null) {
			            groupDetail.setQuestion(groupQuestionRule.getQuestion());
			            groupDetail.setRule(groupQuestionRule.getRule());
			        }
			        


			        // 3️⃣ JSP로 데이터 전달
			        model.addAttribute("groupDetail", groupDetail);
			        model.addAttribute("groupQuestionRule", groupQuestionRule);

			        // 4️⃣ 가입 화면 JSP 이동
			        return "/WEB-INF/view/group/Apply.jsp";
			    }
			    catch (Exception e)
			    {
			        System.out.println(" groupApply() 예외 발생: " + e.getMessage());
			        e.printStackTrace();
			        return "redirect:/mainpage.do";
			    }
			      
			}

	
	@RequestMapping(value="/level.do", method=RequestMethod.GET)
	public String level(Model model)
	{
		return "/WEB-INF/view/group_room/Level.jsp";
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
		//multi = new MultipartRequest(�슂泥�媛앹껜, ���옣寃쎈줈, 理쒕��뾽濡쒕뱶�겕湲�, �씤肄붾뵫諛⑹떇, �뙆�씪紐낆젙梨�);
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
	
	@Transactional
	@RequestMapping(value="/applicationcomplete.do", method=RequestMethod.POST)
	public String groupJoinInsert(HttpServletRequest request, HttpSession session, Model model)
	{
	    try
	    {
	        IGroupJoinDAO dao = sqlSession.getMapper(IGroupJoinDAO.class);
	        
	        // 로그인 체크
	        UserDTO user = (UserDTO)session.getAttribute("user");
	        if(user == null)
	            return "redirect:loginpage.do";
	        
	        // DTO 생성 및 데이터 설정
	     
	        String userCode = user.getUserCode();
	        System.out.println("✅ 로그인 유저 userCode: " + userCode);
	        
	        
	     // 파라미터 추출
	        String groupApplyCode = request.getParameter("groupJoinCode"); // ✅ 이름 확인
	        String introduce = request.getParameter("introduce");
	        String answer = request.getParameter("answer");
	        
	        System.out.println("========== 파라미터 확인 ==========");
	        System.out.println("userCode: " + userCode);
	        System.out.println("groupApplyCode: " + groupApplyCode);
	        System.out.println("introduce: " + introduce);
	        System.out.println("answer: " + answer);
	        
	        // DTO 생성 및 데이터 설정
	        GroupJoinDTO dto = new GroupJoinDTO();
	        dto.setUserCode(userCode);
	        dto.setGroupApplyCode(groupApplyCode);
	        dto.setIntroduce(introduce);
	        dto.setAnswer(answer != null && !answer.trim().isEmpty() ? answer.trim() : ""); // null 방지
	        
	        System.out.println("========== DTO 확인 ==========");
	        System.out.println("DTO.getUserCode(): " + dto.getUserCode());
	        System.out.println("DTO.getGroupApplyCode(): " + dto.getGroupApplyCode());
	        System.out.println("DTO.getIntroduce(): " + dto.getIntroduce());
	        System.out.println("DTO.getAnswer(): " + dto.getAnswer());
	        
	        // DAO 호출
	        System.out.println("========== 프로시저 호출 시작 ==========");
	        dao.insertGroupJoin(dto);
	        System.out.println("========== 프로시저 호출 완료 ==========");
	        
	        model.addAttribute("msg", "모임 가입 신청이 완료되었습니다!");
	        model.addAttribute("success", true);
	        System.out.println("✅ 가입 신청 성공");
	        
	    } catch (Exception e)
	    {
	        System.out.println("========== 에러 발생 ==========");
	        System.out.println("에러 타입: " + e.getClass().getName());
	        System.out.println("에러 메시지: " + e.getMessage());
	        e.printStackTrace();
	        
	        model.addAttribute("msg", "오류가 발생했습니다: " + e.getMessage());
	        model.addAttribute("success", false);
	    }
	    
	    return "/WEB-INF/view/group/ApplicationComplete.jsp";
	}
	
	// /applicationsuccess.do (GET) - 최종 결과 페이지를 보여주는 역할
	@RequestMapping(value="/applicationsuccess.do", method=RequestMethod.GET) 
	public String showApplicationResult(Model model) 
	{
	    // model에 필요한 데이터가 있다면 세션을 통해 넘기거나, GET 파라미터로 처리합니다.
	    return "/WEB-INF/view/group/ApplicationComplete.jsp"; 
	}
	
	@RequestMapping(value="/attendance.do", method=RequestMethod.GET)
	public String attendance(Model model)
	{
		return "/WEB-INF/view/group_room/manage/Attendance.jsp";
	}
	
	@RequestMapping(value = "/updateIntroduce.do", method=RequestMethod.POST)
	public String updateIntroduce(HttpSession session, @RequestParam("groupApplyCode")String groupApplyCode
				, @RequestParam("joinCode")String joinCode, @RequestParam("introduce")String introduce)
	{
		String url = "redirect:home.do?groupApplyCode=" + groupApplyCode;
		
		IGroupJoinDAO joinDAO = sqlSession.getMapper(IGroupJoinDAO.class);
		
		UserDTO user = (UserDTO)session.getAttribute("user");
		String userCode = "UC00000010";
		if(user!=null)
			userCode = user.getUserCode();
		
		joinDAO.updateIntroduce(joinCode, introduce);
		
		return url;
	}	
	
}






























