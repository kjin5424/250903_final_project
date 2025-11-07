package com.test.mybatis.dto;

import java.util.Date;
import java.util.List;

public class InquiryDTO {

    // =========================
    // 문의 정보
    // =========================
    private String inquiryCode;
    private String userCode;
    private String title;        // 🔹 문의 제목 추가
    private String content;
    private Date createdDate;

    // =========================
    // 답변 정보
    // =========================
    private String answerNo;      // 필요하면 시퀀스용
    private String adminId;       // MANAGER_CODE
    private String answerContent; // CONTENT
    private Date answerDate;      // CREATED_DATE

    // =========================
    // 답변 리스트
    // =========================
    private List<InquiryDTO> answers;

    // =========================
    // getter / setter
    // =========================
    public String getInquiryCode() { return inquiryCode; }
    public void setInquiryCode(String inquiryCode) { this.inquiryCode = inquiryCode; }

    public String getUserCode() { return userCode; }
    public void setUserCode(String userCode) { this.userCode = userCode; }

    public String getTitle() { return title; }                // 🔹 추가
    public void setTitle(String title) { this.title = title; } // 🔹 추가

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public String getAnswerNo() { return answerNo; }
    public void setAnswerNo(String answerNo) { this.answerNo = answerNo; }

    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }

    public String getAnswerContent() { return answerContent; }
    public void setAnswerContent(String answerContent) { this.answerContent = answerContent; }

    public Date getAnswerDate() { return answerDate; }
    public void setAnswerDate(Date answerDate) { this.answerDate = answerDate; }

    public List<InquiryDTO> getAnswers() { return answers; }
    public void setAnswers(List<InquiryDTO> answers) { this.answers = answers; }
}
