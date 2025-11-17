package com.test.mybatis.controller.group;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.mybatis.dao.IGroupLevelDAO;
import com.test.mybatis.dto.GroupLevelDTO;

@Controller
public class GroupLevelController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/level.do", method=RequestMethod.GET)
	public String level(Model model, HttpServletRequest request, String groupApplyCode)
	{
		IGroupLevelDAO leveldao = sqlSession.getMapper(IGroupLevelDAO.class);
		
		// 레벨별 최대인원
		List<GroupLevelDTO> typeList = leveldao.getType();
		// model.addAttribute("typeList", typeList);
		// requirements와 benefits 또한 컨트롤러에서 보내는 식으로 하는게 좋을 것 같지만
		// 일단은 넘어가는걸로...이건 일단 무시
		
		// 레벨이 몇인지
		String whatLevel = leveldao.whatLevel(groupApplyCode);
		model.addAttribute("whatLevel", whatLevel);
		
		// 투표 성사 횟수
		
		// 끝난 도전과제 횟수
		
		return "/WEB-INF/view/group_room/Level.jsp";
	}
}
