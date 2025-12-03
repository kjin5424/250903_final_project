package com.test.mybatis.dto;

public class ActivityDTO
{
	// 모임내 활동에 대한 객체
	
	// 주요 속성 구성
	private String groupApplyCode;		// 어느 모임의 활동인지 구분하기 위한 모임코드
	private String place;				// 활동이 일어날 장소(주소)
	private String onOffLine;			// 온/오프라인 유형
	private String activeDate;			// 활동 예정일(시간까지)
	private String content;				// 활동 내용
	private String activityCode;		// 활동 코드
	private String totalMember;			// 활동 발의 당시 모임 내 총 인원
	private String registrants;			// 활동 개시 전까지 활동 참여 의사를 밝힌 인원 수
	private String attendanceMember;	// 실제 활동 참여 인원
	private String time;				// 활동 진행시간
	private String joinCode;			// 활동 발의자의 joinCode
	private String createdDate;			// 활동 발의일자
	private String limitVoteDate;		// 투표 참여 가능 최종일자
	private String activeEndTime;		// 활동이 끝나는 시간(다음날 넘어가면 + 일자)
	private String status;				// 활동에 대한 상태(활동 완료, 활동중, 투표중)
	private int totalDataCount;			// 특정 모임 내 전체 활동 개수
	private int start;					// 페이징 처리를 위한 매개변수로 넣은 변수
	private int end;					// start 와 동일
	private Integer myVoteStatus;		// 현재 사용자의 투표 상태 (1: 참여, 0: 미참, null: 미제출)
	
	// getter / setter 구성
	public String getGroupApplyCode()
	{
		return groupApplyCode;
	}
	public void setGroupApplyCode(String groupApplyCode)
	{
		this.groupApplyCode = groupApplyCode;
	}
	public String getPlace()
	{
		return place;
	}
	public void setPlace(String place)
	{
		this.place = place;
	}
	public String getOnOffLine()
	{
		return onOffLine;
	}
	public void setOnOffLine(String onOffLine)
	{
		this.onOffLine = onOffLine;
	}
	public String getActiveDate()
	{
		return activeDate;
	}
	public void setActiveDate(String activeDate)
	{
		this.activeDate = activeDate;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getActivityCode()
	{
		return activityCode;
	}
	public void setActivityCode(String activityCode)
	{
		this.activityCode = activityCode;
	}
	public String getTotalMember()
	{
		return totalMember;
	}
	public void setTotalMember(String totalMember)
	{
		this.totalMember = totalMember;
	}
	public String getAttendanceMember()
	{
		return attendanceMember;
	}
	public void setAttendanceMember(String attendanceMember)
	{
		this.attendanceMember = attendanceMember;
	}
	public String getTime()
	{
		return time;
	}
	public void setTime(String time)
	{
		this.time = time;
	}
	public String getJoinCode()
	{
		return joinCode;
	}
	public void setJoinCode(String joinCode)
	{
		this.joinCode = joinCode;
	}
	public String getRegistrants()
	{
		return registrants;
	}
	public void setRegistrants(String registrants)
	{
		this.registrants = registrants;
	}
	public String getCreatedDate()
	{
		return createdDate;
	}
	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}
	public String getLimitVoteDate()
	{
		return limitVoteDate;
	}
	public void setLimitVoteDate(String limitVoteDate)
	{
		this.limitVoteDate = limitVoteDate;
	}
	public String getActiveEndTime()
	{
		return activeEndTime;
	}
	public void setActiveEndTime(String activeEndTime)
	{
		this.activeEndTime = activeEndTime;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	public int getTotalDataCount()
	{
		return totalDataCount;
	}
	public void setTotalDataCount(int totalDataCount)
	{
		this.totalDataCount = totalDataCount;
	}
	public int getStart()
	{
		return start;
	}
	public void setStart(int start)
	{
		this.start = start;
	}
	public int getEnd()
	{
		return end;
	}
	public void setEnd(int end)
	{
		this.end = end;
	}
	public Integer getMyVoteStatus()
	{
		return myVoteStatus;
	}
	public void setMyVoteStatus(Integer myVoteStatus)
	{
		this.myVoteStatus = myVoteStatus;
	}
	
}
