/*===================
  GroupJoinDTO.java
 ====================*/
package com.test.mybatis.dto;

public class GroupJoinDTO
{
	private String groupJoinCode;		// 모임 가입 신청 Code
	private String groupApplyCode;		// 어떤 모임에 신청했는지
	private String userCode;			// 누가 신청했는지

	private String selfIntro;			// 한 줄 자기소개
	private String questionCode;		// 가입 질문 코드
	private String questionAnswer;		// 가입 질문 답변
	
	// 신청 상태 	
	private String status;				// 신청 상태
	private String joinDate;			// 신청 날짜
	private String AnswerDate;			// 가입 처리 날짜
	
	
	// 추가 속성
	private UserDTO user;				// 신청한 유저 정보
	private GroupDTO group;				// 신청 대상 모임 정보
	
	// getter / setter 
	public String getGroupJoinCode()
	{
		return groupJoinCode;
	}
	public void setGroupJoinCode(String groupJoinCode)
	{
		this.groupJoinCode = groupJoinCode;
	}
	public String getGroupApplyCode()
	{
		return groupApplyCode;
	}
	public void setGroupApplyCode(String groupApplyCode)
	{
		this.groupApplyCode = groupApplyCode;
	}
	public String getUserCode()
	{
		return userCode;
	}
	public void setUserCode(String userCode)
	{
		this.userCode = userCode;
	}
	public String getSelfIntro()
	{
		return selfIntro;
	}
	public void setSelfIntro(String selfIntro)
	{
		this.selfIntro = selfIntro;
	}
	public String getQuestionCode()
	{
		return questionCode;
	}
	public void setQuestionCode(String questionCode)
	{
		this.questionCode = questionCode;
	}
	public String getQuestionAnswer()
	{
		return questionAnswer;
	}
	public void setQuestionAnswer(String questionAnswer)
	{
		this.questionAnswer = questionAnswer;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	public String getJoinDate()
	{
		return joinDate;
	}
	public void setJoinDate(String joinDate)
	{
		this.joinDate = joinDate;
	}
	public String getAnswerDate()
	{
		return AnswerDate;
	}
	public void setAnswerDate(String answerDate)
	{
		AnswerDate = answerDate;
	}
	public UserDTO getUser()
	{
		return user;
	}
	public void setUser(UserDTO user)
	{
		this.user = user;
	}
	public GroupDTO getGroup()
	{
		return group;
	}
	public void setGroup(GroupDTO group)
	{
		this.group = group;
	}
	

	
}
