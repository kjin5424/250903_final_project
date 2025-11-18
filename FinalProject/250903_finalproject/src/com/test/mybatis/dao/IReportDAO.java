package com.test.mybatis.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.ReportDTO;

public interface IReportDAO {
    // 모임 신고 등록
    public int insertReport(ReportDTO dto);
    
    // 컨텐츠 신고 등록
    public int insertContent(ReportDTO dto);
    
    // 모임원 신고 등록
    public int insertMember(ReportDTO dto);
    
    // 매니저(관리자)가 열람하는 특정 유저의 정보 페이지에서 사용될 해당 유저의 피신고 내역
    public ArrayList<ReportDTO> reportedListForManager(@Param("userCode") String userCode);
    
    // 매니저(관리자)가 열람하는 특정 유저의 정보 페이지에서 사용될 해당 유저의 전체(능동) 신고 내역
    public ArrayList<ReportDTO> reportListForManager(@Param("userCode") String userCode);
}
