package com.test.mybatis.dao;

import java.util.List;
import com.test.mybatis.dto.InquiryDTO;

public interface IInquiryDAO {

    // 사용자별 문의 내역 조회
    public List<InquiryDTO> list(String userCode);

    // 특정 문의 상세 조회
    public InquiryDTO detail(String inquiryCode);

    // 전체 문의 리스트 조회 (관리자용)
    public List<InquiryDTO> all();

    // 문의 등록
    public int add(InquiryDTO inquiryDTO);

    // 답변 등록
    public int answer(InquiryDTO inquiryDTO);

    // 특정 문의에 대한 답변 조회
    public List<InquiryDTO> answers(String inquiryCode);
}
