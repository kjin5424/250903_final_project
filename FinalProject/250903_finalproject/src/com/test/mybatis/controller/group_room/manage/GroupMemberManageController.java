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
public class GroupMemberManageController
{
	@Autowired
	private SqlSession sqlSession;
	
	
	@ResponseBody
	@RequestMapping(value="/kickmember_process.do", method=RequestMethod.POST)
	public Map<String, Object> kickMemberProcess(
	        @RequestParam("joinCode") String joinCode,
	        @RequestParam("groupApplyCode") String groupApplyCode,
	        @RequestParam("quitReason") String quitReason,
	        HttpServletRequest request)
	{
		Map<String, Object> result = new HashMap<>();
		
		try
		{
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("user");
			
			if(user == null)
			{
				result.put("status", "error");
				result.put("msg", "로그인이 필요합니다.");
				return result;
			}
			
			IGroupMemberManageDAO dao = sqlSession.getMapper(IGroupMemberManageDAO.class);
			
			System.out.println("========== 강퇴 처리 시작 ==========");
			System.out.println("joinCode: " + joinCode);
			System.out.println("groupApplyCode: " + groupApplyCode);
			System.out.println("quitReason: " + quitReason);
			
			int inserted = dao.insertquitmember(joinCode, quitReason);
			System.out.println("✅ QUIT_MEMBER 저장: " + inserted + "건");
			
			if(inserted > 0)
			{
				result.put("status", "success");
				result.put("msg", "모임원을 퇴출했습니다.");
			}
			else
			{
				result.put("status", "error");
				result.put("msg", "퇴출 처리에 실패했습니다.");
			}
		}
		catch (Exception e)
		{
			System.out.println("========== 강퇴 예외 발생 ==========");
			e.printStackTrace();
			result.put("status", "error");
			result.put("msg", "서버 오류: " + e.getMessage());
		}
		
		return result;
	}
	
}
