package com.test.mybatis.dto;

public class GroupMemberManageDTO
{
	private String quitType;
	private String quitReason;

	private String quitReasonCode;
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
	public String getUserCode()
	{
		return userCode;
	}
	public String getQuitReasonCode() {
		return quitReasonCode;
	}
	public void setQuitReasonCode(String quitReasonCode) {
		this.quitReasonCode = quitReasonCode;
	}
	public void setUserCode(String userCode)
	{
		this.userCode = userCode;
	}
}
