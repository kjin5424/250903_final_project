package com.test.mybatis.dao;

import com.test.mybatis.dto.ReportDTO;

public interface IReportDAO {
    // 모임 신고 등록
    public int insertReport(ReportDTO dto);
    
    // 컨텐츠 신고 등록
    public int insertContent(ReportDTO dto);
    
    // 모임원 신고 등록
    public int insertMember(ReportDTO dto);
    
    
}
