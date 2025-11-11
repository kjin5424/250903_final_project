package com.test.mybatis.controller.group_room.manage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.mybatis.dao.IGroupMemberManageDAO;
import com.test.mybatis.dto.GroupMemberManageDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class GroupMemberManage
{
	@Autowired
	private SqlSession sqlSession;
	
	@ResponseBody
	@RequestMapping(value="/kickmember_process.do", method=RequestMethod.POST)
	public Map<String, Object> kickMemberProcess(
	        @RequestParam("joinCode") String joinCode,
	        @RequestParam("groupApplyCode") String groupApplyCode,
	        @RequestParam("quitReason") String quitReason, HttpServletRequest request ) {

		  Map<String, Object> result = new HashMap<>();
		    try {
		        HttpSession session = request.getSession();
		        UserDTO user = (UserDTO) session.getAttribute("user");
		        IGroupMemberManageDAO dao = sqlSession.getMapper(IGroupMemberManageDAO.class);
		        GroupMemberManageDTO dto = new GroupMemberManageDTO();

		        dto.setJoinCode(joinCode);
		        dto.setQuitReason(quitReason);

		        dao.insertquitmember(dto);

		        result.put("status", "success");
		        result.put("msg", joinCode + "님이 퇴출되었습니다.");
		    } catch (Exception e) {
		        result.put("status", "fail");
		        result.put("msg", "퇴출 처리 중 오류가 발생했습니다.");
		        e.printStackTrace();
		    }
		    return result;
	}
	

	
}
