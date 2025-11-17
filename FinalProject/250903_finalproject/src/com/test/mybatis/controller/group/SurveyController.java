package com.test.mybatis.controller.group;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.test.mybatis.dao.ISurveyDAO;
import com.test.mybatis.dto.SurveyDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class SurveyController
{
    @Autowired
    private SqlSession sqlSession;

    /*
    // 설문 대상 여부 확인
    @RequestMapping("/surveycheck.do")
    @ResponseBody
    public String surveyCheck(HttpSession session)
    {
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null)
            return "0";  // 로그인 안 됐거나 세션 없음

        String userCode = user.getUserCode();
        ISurveyDAO dao = sqlSession.getMapper(ISurveyDAO.class);
        int result = dao.checkSurveyTarget(userCode);
        return String.valueOf(result);
    }
    */

    // 설문 팝업 페이지
    @RequestMapping(value="/reportmembersurvey.do", method=RequestMethod.GET)
    public String surveyPopup()
    {
        return "/WEB-INF/view/group_room/ReportMemberSurvey.jsp";
    }

    // 설문 제출
    @RequestMapping(value="/reportmembersurvey.do", method=RequestMethod.POST)
    public String surveySubmit(HttpSession session, SurveyDTO dto)
    {
        ISurveyDAO dao = sqlSession.getMapper(ISurveyDAO.class);
		/* UserDTO user = (UserDTO) session.getAttribute("user"); */

		// 로그인 기능 없으므로 고정값 사용 (임시 사용자)
		dto.setUserCode("UC00000033");
		
		dao.insertSurvey(dto);

		// 팝업창 닫기용 완료 페이지로 이동 (mainpage.do 제거)
		return "/WEB-INF/view/group_room/ReportMemberSurvey.jsp";
    }
}
