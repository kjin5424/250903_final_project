/*==========================
    ISurveyDAO.java
==========================*/
package com.test.mybatis.dao;

import com.test.mybatis.dto.SurveyDTO;

public interface ISurveyDAO
{
	// 설문 대상 여부 확인 
    //public boolean checkSurveyTarget(String userCode, String groupApplyCode);
	
	// 설문 응답 저장
    public int insertSurvey(SurveyDTO dto);
}
