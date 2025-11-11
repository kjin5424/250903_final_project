/*==========================
    ISurveyDAO.java
==========================*/
package com.test.mybatis.dao;

import com.test.mybatis.dto.SurveyDTO;

public interface ISurveyDAO
{
	// 설문 대상 여부 확인
    //public int checkSurveyTarget(String userCode);
	
	// 설문 응답 저장
    public int insertSurvey(SurveyDTO dto);
}
