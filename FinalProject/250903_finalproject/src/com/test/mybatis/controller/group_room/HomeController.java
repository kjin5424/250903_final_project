package com.test.mybatis.controller.group_room;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IGroupDAO;
import com.test.mybatis.dao.IGroupJoinDAO;
import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.GroupJoinDTO;


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
	
	@RequestMapping(value="/groupcreate.do", method=RequestMethod.GET)
	public String groupCreate(Model model)
	{
		return "/WEB-INF/view/group/GroupCreate.jsp";
	}
	

	
	@RequestMapping(value="/groupcreatecomplete.do", method= RequestMethod.POST)
	public String groupCreateComplete(GroupDTO dto,Model model)
	{
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
	    String message = "";
	    
	    try
	    {
	        // ✅ 디버깅용 로그
	        System.out.println("==== 전송된 DTO 값 확인 ====");
	        System.out.println("proposerCode = " + dto.getProposerCode());
	        System.out.println("groupTitle = " + dto.getGroupTitle());
	        System.out.println("groupContent = " + dto.getGroupContent());
	        System.out.println("onOffType = " + dto.getOnOffType());
	        System.out.println("frequencyType = " + dto.getFrequencyType());
	        System.out.println("difficultyType = " + dto.getDifficultyType());
	        System.out.println("topic = " + dto.getTopic());
	        System.out.println("youthFriendlyType = " + dto.getYouthFriendlyType());
	        System.out.println("genderType = " + dto.getGenderType());
	        System.out.println("question = " + dto.getQuestion());
	        System.out.println("rule = " + dto.getRule());
	        System.out.println("kickOut = " + dto.getKickOut());
	        System.out.println("password = " + dto.getPassword());
	        System.out.println("region = " + dto.getRegion());
	        System.out.println("savePath = " + dto.getSavePath());
	        System.out.println("===================");
	        
	        // ✅ 기본값 설정 (kickOut이 0이면 기본값 4)
	        if (dto.getKickOut() == 0) {
	            dto.setKickOut(4);
	        }
	        
	        int result = dao.groupApply(dto);
	        
	        if (result > 0)
	        {
	            message = "모임 개설 신청이 완료되었습니다.";
	        } 
	        else
	        {
	            message = "모임 개설 신청이 실패했습니다.";
	        }
	            
	    } 
	    catch (Exception e)
	    {
	        message = "오류 발생 : " + e.getMessage();
	        e.printStackTrace(); // ✅ 전체 스택 트레이스 출력
	    }
	    
	    model.addAttribute("message", message);
	    model.addAttribute("groupTitle", dto.getGroupTitle());
	    
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






























