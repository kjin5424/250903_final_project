package com.test.mybatis.dto;

public class GroupDTO
{
	private String groupApplyCode;	// 모임 개설 코드
	private String title;			// 가장 최신값의 제목
	private String groupContent;	// 가장 최신값의 모임 설명
	private String topic;			// 가장 최신 값의 모임 주제
	private String topicType;		// 가장 최신 값 모임 주제의 타입
	private String youthFriendly;	// 청소년 환영 여부
	private String gender;			// 동성 제한 여부
	private String question;		// 가장 최신 값의 쌩 가입질문
	private String questionCode;	// 가장 최신값의 가입 질문의 코드
	private String rule;			// 가장 최신값의 모임 규칙
	private String password;		// 가장 최신값 비번
	private String openDate;		// 정식 개설일
	private String frequency;		// 빈도 타입
	private String createdDate;		// 모임 개설 신청일
	
	// getter / setter
	public String getGroupApplyCode()
	{
		return groupApplyCode;
	}
	public void setGroupApplyCode(String groupApplyCode)
	{
		this.groupApplyCode = groupApplyCode;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getGroupContent()
	{
		return groupContent;
	}
	public void setGroupContent(String groupContent)
	{
		this.groupContent = groupContent;
	}
	public String getTopic()
	{
		return topic;
	}
	public void setTopic(String topic)
	{
		this.topic = topic;
	}
	public String getTopicType()
	{
		return topicType;
	}
	public void setTopicType(String topicType)
	{
		this.topicType = topicType;
	}
	public String getYouthFriendly()
	{
		return youthFriendly;
	}
	public void setYouthFriendly(String youthFriendly)
	{
		this.youthFriendly = youthFriendly;
	}
	public String getGender()
	{
		return gender;
	}
	public void setGender(String gender)
	{
		this.gender = gender;
	}
	public String getQuestion()
	{
		return question;
	}
	public void setQuestion(String question)
	{
		this.question = question;
	}
	public String getQuestionCode()
	{
		return questionCode;
	}
	public void setQuestionCode(String questionCode)
	{
		this.questionCode = questionCode;
	}
	public String getRule()
	{
		return rule;
	}
	public void setRule(String rule)
	{
		this.rule = rule;
	}
	public String getPassword()
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	public String getOpenDate()
	{
		return openDate;
	}
	public void setOpenDate(String openDate)
	{
		this.openDate = openDate;
	}
	public String getFrequency()
	{
		return frequency;
	}
	public void setFrequency(String frequency)
	{
		this.frequency = frequency;
	}
	public String getCreatedDate()
	{
		return createdDate;
	}
	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}
	public String getJoinDate()
	{
		return joinDate;
	}
	public void setJoinDate(String joinDate)
	{
		this.joinDate = joinDate;
	}
	public String getQuithis()
	{
		return quithis;
	}
	public void setQuithis(String quithis)
	{
		this.quithis = quithis;
	}
	public int getYouthFriendlyType()
	{
		return youthFriendlyType;
	}
	public void setYouthFriendlyType(int youthFriendlyType)
	{
		this.youthFriendlyType = youthFriendlyType;
	}
	public int getGenderType()
	{
		return genderType;
	}
	public void setGenderType(int genderType)
	{
		this.genderType = genderType;
	}
	public int getKickout()
	{
		return kickout;
	}
	public void setKickout(int kickout)
	{
		this.kickout = kickout;
	}
	public int getCurrentMemberCount()
	{
		return currentMemberCount;
	}
	public void setCurrentMemberCount(int currentMemberCount)
	{
		this.currentMemberCount = currentMemberCount;
	}
	public int getHeadCount()
	{
		return headCount;
	}
	public void setHeadCount(int headCount)
	{
		this.headCount = headCount;
	}
	public int getGroupLevel()
	{
		return groupLevel;
	}
	public void setGroupLevel(int groupLevel)
	{
		this.groupLevel = groupLevel;
	}
	public int getFrequencyType()
	{
		return frequencyType;
	}
	public void setFrequencyType(int frequencyType)
	{
		this.frequencyType = frequencyType;
	}
	private String joinDate;		// 참여일
	private String quithis;			// 탈퇴 여부

	private int youthFriendlyType;	// 청소년 환영 여부
	private int genderType;			// 동성 제한 여부
	private int kickout;			// 가장 최신 값의 미참여 자동 강퇴 횟수
	private int currentMemberCount;	// 현재의 모임원 수
	private int headCount;			// 가장 최신의 모임원 상한 수
	private int groupLevel;			// 가장 최신의 모임 레벨 = 역대 가장 높은 레벨
	private int frequencyType;		// 빈도 타입에 대한 코드

}
