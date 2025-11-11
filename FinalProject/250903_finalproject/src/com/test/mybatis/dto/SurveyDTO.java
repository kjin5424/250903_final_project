package com.test.mybatis.dto;

public class SurveyDTO {
	private String surveyCode;
	private String userCode;
	private String groupApplyCode;
	private int surveyAnswerType; // 1=동의, 2=비동의
	private String detailContent;
	private String createdDate;

	// getter/setter
	public String getSurveyCode() {
		return surveyCode;
	}

	public void setSurveyCode(String surveyCode) {
		this.surveyCode = surveyCode;
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

	public int getSurveyAnswerType() {
		return surveyAnswerType;
	}

	public void setSurveyAnswerType(int surveyAnswerType) {
		this.surveyAnswerType = surveyAnswerType;
	}

	public String getDetailContent() {
		return detailContent;
	}

	public void setDetailContent(String detailContent) {
		this.detailContent = detailContent;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
}
