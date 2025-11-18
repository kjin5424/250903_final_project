package com.test.mybatis.dto;

import java.util.Date;

public class ReportDTO {
    // 모임 신고
    private String reportGroupCode; // REPORT_GROUP_CODE
    private String userCode;        // 신고자
    private String groupApplyCode;  // 신고대상 (DB VARCHAR2)
    private int reportGroupType; // 신고 유형 
    
    // 컨텐츠 신고
    private String reportPostCode;   // 게시글 신고 코드
    private String joinCode;		// 모임 가입 신청 코드
    private String postCode;         // 게시글 코드
    private int reportContentType; // 컨텐츠 신고 유형 
    
    // 모임원 신고
    private String reportMemberCode;  // REPORT_MEMBER_CODE
    private String reporterCode;      // REPORTER_CODE
    private String reporteeCode;      // REPORTEE_CODE
    private int reportMemberType;     // REPORT_MEMBER_TYPE
    private String content;           // CONTENT
    
    private String processType;
    private String reportType;
    
    public String getReportType()
	{
		return reportType;
	}

	public void setReportType(String reportType)
	{
		this.reportType = reportType;
	}

	public String getProcessType()
	{
		return processType;
	}

	public void setProcessType(String processType)
	{
		this.processType = processType;
	}

	private Date createdDate;        // 작성일

    // Getter & Setter
	public String getReportGroupCode() {
		return reportGroupCode;
	}

	public void setReportGroupCode(String reportGroupCode) {
		this.reportGroupCode = reportGroupCode;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getGroupApplyCode() {
		return groupApplyCode;
	}

	public void setGroupApplyCode(String groupApplyCode) {
		this.groupApplyCode = groupApplyCode;
	}

	public int getReportGroupType() {
		return reportGroupType;
	}

	public void setReportGroupType(int reportGroupType) {
		this.reportGroupType = reportGroupType;
	}

	public String getReportPostCode() {
		return reportPostCode;
	}

	public void setReportPostCode(String reportPostCode) {
		this.reportPostCode = reportPostCode;
	}

	public String getJoinCode() {
		return joinCode;
	}

	public void setJoinCode(String joinCode) {
		this.joinCode = joinCode;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public int getReportContentType() {
		return reportContentType;
	}

	public void setReportContentType(int reportContentType) {
		this.reportContentType = reportContentType;
	}

	public String getReportMemberCode() {
		return reportMemberCode;
	}

	public void setReportMemberCode(String reportMemberCode) {
		this.reportMemberCode = reportMemberCode;
	}

	public String getReporterCode() {
		return reporterCode;
	}

	public void setReporterCode(String reporterCode) {
		this.reporterCode = reporterCode;
	}

	public String getReporteeCode() {
		return reporteeCode;
	}

	public void setReporteeCode(String reporteeCode) {
		this.reporteeCode = reporteeCode;
	}

	public int getReportMemberType() {
		return reportMemberType;
	}

	public void setReportMemberType(int reportMemberType) {
		this.reportMemberType = reportMemberType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}


    
	

 
}
