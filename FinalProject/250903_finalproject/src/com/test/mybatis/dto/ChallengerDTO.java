package com.test.mybatis.dto;

public class ChallengerDTO
{
	private String joinCode;			// 참여자 코드
	private String successedCount;		// 달성 수
	private String successed;			// 달성 여부
	private String nickname;			// 참여자 닉네임
	private String successedDate;		// 달성 날짜
	
	// getter / setter
	public String getJoinCode()
	{
		return joinCode;
	}
	public void setJoinCode(String joinCode)
	{
		this.joinCode = joinCode;
	}
	public String getSuccessedCount()
	{
		return successedCount;
	}
	public void setSuccessedCount(String successedCount)
	{
		this.successedCount = successedCount;
	}
	public String getSuccessed()
	{
		return successed;
	}
	public void setSuccessed(String successed)
	{
		this.successed = successed;
	}
	public String getNickname()
	{
		return nickname;
	}
	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}
	public String getSuccessedDate()
	{
		return successedDate;
	}
	public void setSuccessedDate(String successedDate)
	{
		this.successedDate = successedDate;
	}
}
