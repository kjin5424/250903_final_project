package com.test.mybatis.controller.survey;

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
    
    // 설문 페이지
    @RequestMapping(value="/reportmembersurvey.do", method=RequestMethod.GET)
    public String surveyPopup()
    {
        return "/WEB-INF/view/group_room/ReportMemberSurvey.jsp";
    }
    
    // 설문 제출 - db 없음/ 세팅 유지 
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
    
    // / 설문 대상자 체크 >> db 없음/ 세팅 유지 
    /*
    @RequestMapping(value="/reportmembersurvey.do", method=RequestMethod.POST)
    public String surveyPopup(HttpSession session, @RequestParam("groupApplyCode") String groupApplyCode) {
        // 1. 로그인 사용자 가져오기
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            // 로그인 안 됐으면 팝업 띄우지 않음 (메인 페이지로 이동)
            return "redirect:/mainpage.do";
        }
        
        String userCode = user.getUserCode();
        
        // 2. DAO를 이용해서 신고자/피신고자 여부 체크
        ISurveyDAO dao = sqlSession.getMapper(ISurveyDAO.class);
        
        boolean isTarget = dao.checkSurveyTarget(userCode, groupApplyCode); 
        // checkSurveyTargetForPopup는 "사용자가 신고자/피신고자가 아니면서, 신고가 존재하는 모임원"인지 boolean 반환
        
        if (!isTarget) {
            // 설문 참여 대상이 아니면 팝업 띄우지 않음
            return "redirect:/mainpage.do";
        }

        // 3. 설문 참여 가능 → JSP 반환
        return "/WEB-INF/view/group_room/ReportMemberSurvey.jsp";
    }
	*/
}
