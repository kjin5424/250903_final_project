package com.test.mybatis.controller.group_room.manage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.test.mybatis.dto.GroupJoinDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class GroupManageController
{
	@Autowired
	private SqlSession sqlSession;
	
    @RequestMapping(value="/applicant.do", method = RequestMethod.GET)
    public String groupJoinList(@RequestParam("groupApplyCode") String groupApplyCode, Model model, HttpServletRequest request)
    {
    	HttpSession session = request.getSession();
    	UserDTO user = (UserDTO)session.getAttribute("user");
    	
    	// 로그인 페이지
    	 if(user == null) {
             return "redirect:/loginpage.do";
         }
        IGroupJoinDAO dao = sqlSession.getMapper(IGroupJoinDAO.class);
        IGroupDAO groupDao = sqlSession.getMapper(IGroupDAO.class);

        // 해당 모임의 가입 신청자 목록 조회
        List<GroupJoinDTO> applicantList = dao.selectGroupJoinById(groupApplyCode);
        
        int waitingCount = dao.countWaitingGroupMember(groupApplyCode);
        
        model.addAttribute("waitingCount", waitingCount);

        // 결과를 JSP로 전달
        model.addAttribute("applicantList", applicantList);

        // JSP 경로 리턴
        return "/WEB-INF/views/group_room/Applicant.jsp";
    }
}
