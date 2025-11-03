package com.test.mybatis.dto;

import java.util.Date;

public class InquiryDTO {
	

    // ----------------- 문의 기본 정보 -----------------
    private int inquiryNo;        // 문의번호
    private String userId;        // 작성자 ID
    private String title;         // 문의 제목
    private String content;       // 문의 내용
    private String type;          // 문의 유형 
    private Date regDate;         // 접수일
    private String status;        // 답변 상태 (대기, 완료 등)

    // ----------------- 답변 정보 -----------------
    private int answerNo;         // 답변 번호
    private String adminId;       // 관리자 ID
    private String answerContent; // 답변 내용
    private Date answerDate;      // 답변일

    // ----------------- 작성자/참고 정보 -----------------
    private String nickname;      // 작성자 닉네임
    private String email;         // 작성자 이메일
    
	public int getInquiryNo() {
		return inquiryNo;
	}
	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getAnswerNo() {
		return answerNo;
	}
	public void setAnswerNo(int answerNo) {
		this.answerNo = answerNo;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAnswerContent() {
		return answerContent;
	}
	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}
	public Date getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

}
