/*
	AttendanceDTO.java
*/
package com.test.mybatis.dto;

public class AttendanceDTO
{
	// 주요 속성 구성
	private String activityVoteCode;	// 활동 참여자의 활동 참여 코드
	private String activityCode;		// 활동코드
	private String joinCode;			// 활돔 참여자의 모임 참여 코드
	private int totalActivityCount;		// 활동 참여자의 누적 활동 참여 의사 횟수
	private int totalAttendanceCount;	// 활동 참여자의 누적 실제 활동 참여 횟수
	private String position;			// 활동 참여자의 모임 내 역할
	
	// getter / setter 구성
	public String getActivityVoteCode()
	{
		return activityVoteCode;
	}
	public void setActivityVoteCode(String activityVoteCode)
	{
		this.activityVoteCode = activityVoteCode;
	}
	public String getActivityCode()
	{
		return activityCode;
	}
	public void setActivityCode(String activityCode)
	{
		this.activityCode = activityCode;
	}
	public String getJoinCode()
	{
		return joinCode;
	}
	public void setJoinCode(String joinCode)
	{
		this.joinCode = joinCode;
	}
	public int getTotalActivityCount()
	{
		return totalActivityCount;
	}
	public void setTotalActivityCount(int totalActivityCount)
	{
		this.totalActivityCount = totalActivityCount;
	}
	public int getTotalAttendanceCount()
	{
		return totalAttendanceCount;
	}
	public void setTotalAttendanceCount(int totalAttendanceCount)
	{
		this.totalAttendanceCount = totalAttendanceCount;
	}
	public String getPosition()
	{
		return position;
	}
	public void setPosition(String position)
	{
		this.position = position;
	}
	
	
}
