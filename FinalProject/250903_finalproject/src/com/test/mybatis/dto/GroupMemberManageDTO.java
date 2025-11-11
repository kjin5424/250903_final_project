package com.test.mybatis.dto;

public class GroupMemberManageDTO
{
	private String quitType;	// 강퇴 타입
	private String quitReason;	// 강퇴 사유
	private String joinCode;
	private String groupApplyCode;
	private String userCode;
	
	// getter / setter 
	public String getQuitType()
	{
		return quitType;
	}
	public void setQuitType(String quitType)
	{
		this.quitType = quitType;
	}
	public String getJoinCode()
	{
		return joinCode;
	}
	public void setJoinCode(String joinCode)
	{
		this.joinCode = joinCode;
	}
	public String getGroupApplyCode()
	{
		return groupApplyCode;
	}
	public void setGroupApplyCode(String groupApplyCode)
	{
		this.groupApplyCode = groupApplyCode;
	}
	public String getQuitReason()
	{
		return quitReason;
	}
	public void setQuitReason(String quitReason)
	{
		this.quitReason = quitReason;
	}
	
}
