package com.test.mybatis.dto;

public class ChallengeInfoDTO
{
	// 주요 속성 구성
	private String challengeCode;	// 도전과제 코드
	private String title;			// 도전과제 제목
	private String startDate;		// 도전과제 시작예정일
	private String challengeType;	// 도전타입(주간, 월간)
	private String endDate;			// 도전과제 종료일
	private String createdDate;		// 도전과제 등록일
	private String joinCode;		// 도전과제 등록자 joinCode
	private String groupApplyCode;	// 도전과제가 소속된 모임의 groupApplyCode
	private String challengeMember;	// 도전과제 참여자(인원수)
	private String challengeCheck;	// 도전과제 달성(challenge_check 테이블의 레코드 개수)
	private String challengeDetail;	// 도전과제 세부 달성 조건 개수
	private String content;			// 도전과제 내용
	private String status;			// 도전과제 상태(진행중, 종료, 진행예정)
	private String datePercent;		// 도전과제 날짜 진행도
	private String nickname;
	
	// getter / setter 구성
	public String getChallengeCode()
	{
		return challengeCode;
	}
	public void setChallengeCode(String challengeCode)
	{
		this.challengeCode = challengeCode;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getStartDate()
	{
		return startDate;
	}
	public void setStartDate(String startDate)
	{
		this.startDate = startDate;
	}
	public String getChallengeType()
	{
		return challengeType;
	}
	public void setChallengeType(String challengeType)
	{
		this.challengeType = challengeType;
	}
	public String getEndDate()
	{
		return endDate;
	}
	public void setEndDate(String endDate)
	{
		this.endDate = endDate;
	}
	public String getCreatedDate()
	{
		return createdDate;
	}
	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
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
	public String getChallengeMember()
	{
		return challengeMember;
	}
	public void setChallengeMember(String challengeMember)
	{
		this.challengeMember = challengeMember;
	}
	public String getChallengeCheck()
	{
		return challengeCheck;
	}
	public void setChallengeCheck(String challengeCheck)
	{
		this.challengeCheck = challengeCheck;
	}
	public String getChallengeDetail()
	{
		return challengeDetail;
	}
	public void setChallengeDetail(String challengeDetail)
	{
		this.challengeDetail = challengeDetail;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	public String getDatePercent()
	{
		return datePercent;
	}
	public void setDatePercent(String datePercent)
	{
		this.datePercent = datePercent;
	}
	public String getNickname()
	{
		return nickname;
	}
	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}
}
