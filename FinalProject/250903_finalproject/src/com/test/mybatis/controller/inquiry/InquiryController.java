package com.test.mybatis.controller.inquiry;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IInquiryDAO;
import com.test.mybatis.dto.InquiryDTO;
import com.test.mybatis.dto.UserDTO;

@Controller
public class InquiryController {

	 @Autowired
	    private SqlSession sqlSession;

	    /*
	    @RequestMapping(value = "/inquirylist.do", method = RequestMethod.GET)
	    public String inquiryList(Model model) {
	    	
	    	 return "/WEB-INF/view/inquiry/List.jsp";	
	    }*/
	   	    
	    // 문의 내역 리스트 출력
	    @RequestMapping(value = "/profilemodify.do", method = RequestMethod.GET)
	    public String inquiryList(Model model) {
	    	IInquiryDAO dao = sqlSession.getMapper(IInquiryDAO.class);
	        List<InquiryDTO> inquiryList = dao.list("UC00000020");  // 사용자 ID로 리스트 조회 (예시)
	        model.addAttribute("inquiries", inquiryList);
	        return "/WEB-INF/view/profile/ProfileModify.jsp";  // 경로 확인
	    }
	    
	    // 문의 등록
	    @RequestMapping(value = "/inquiry/write.do", method = RequestMethod.GET)
	    public String writePage(Model model) {
	    	
	    	
	        return "/WEB-INF/view/inquiry/Write.jsp";
	    }
	    
	    
	    
	    
	    
	    
	    
	    // 문의 상세 및 답변
	    @RequestMapping(value = "/inquirydetail.do", method = RequestMethod.GET)
	    public String inquiryDetail(@RequestParam(required = false) String inquiryCode, Model model) {
	        IInquiryDAO dao = sqlSession.getMapper(IInquiryDAO.class);

	        if (inquiryCode == null || inquiryCode.isEmpty()) {
	            return "redirect:/profilemodify.do";  // 안전하게 리스트로 리다이렉트
	        }

	        InquiryDTO inquiry = dao.detail(inquiryCode);
	        List<InquiryDTO> answerList = dao.answers(inquiryCode);
	        inquiry.setAnswers(answerList); // DTO에 필드 추가 필요

	        model.addAttribute("inquiry", inquiry);
	        return "/WEB-INF/view/inquiry/Detail.jsp";
	    }
	     
}
