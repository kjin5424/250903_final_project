package com.test.mybatis.controller.group;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IAttendanceDAO;
import com.test.mybatis.dto.AttendanceDTO;

@Controller
public class AttendanceController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/attendance.do", method=RequestMethod.GET)
	public String attendance(Model model)
	{
		IAttendanceDAO attendanceDAO = sqlSession.getMapper(IAttendanceDAO.class);
		
		//model.addAttribute("attendanceList", attendanceDAO.getAttendanceList(groupApplyCode));
		
		return "/WEB-INF/view/group_room/manage/Attendance.jsp";
	}
	
	@RequestMapping(value = "/attendanceList.do")
	public ArrayList<AttendanceDTO> getAttendanceList(Model model, @RequestParam("groupApplyCode") String groupApplyCode)
	{
		ArrayList<AttendanceDTO> result = new ArrayList<AttendanceDTO>();
		
		
		
		return result;
	}
}
