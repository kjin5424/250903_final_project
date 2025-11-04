package com.test.mybatis.dto;

public class GroupDTO
{
	private String groupApplyCode;	// 모임 개설 코드
	private String proposerCode;	// 신청자 코드
	private String groupTitle;		// 가장 최신값의 제목
	private String groupContent;	// 가장 최신값의 모임 설명
	private String topicType;		// 가장 최신 값 모임 주제의 타입
	private String topic;			// 가장 최신 값의 모임 주제
	private String youthFriendlyType;// 청소년 환영 타입  
	private String youthFriendly;	// 청소년 환영 여부
	private String genderType;		// 동성 제한 타입
	private String gender;			// 동성 제한 여부
	private String questionCode;	// 가장 최신값의 가입 질문의 코드
	private String question;		// 가장 최신 값의 쌩 가입질문
	private String rule;			// 가장 최신값의 모임 규칙
	private int kickOut;			// 가장 최신 값의 미참여 자동 강퇴 횟수
	private String password;		// 가장 최신값 비번
	private int headCount;			// 가장 최신의 모임원 상한 수
	private int groupLevel;			// 가장 최신의 모임 레벨 = 역대 가장 높은 레벨
	private int maxCount;			// 레벨 비례 최대 인원 수
	private String region;			// 가장 최신 모임 지역
	private String onOffType;		// 온오프 코드
	private String onOff;			// 온오프 내용
	private String frequencyType;	// 빈도 타입에 대한 코드
	private String frequency;		// 빈도 타입
	private String difficultyType;	// 난이도 코드
	private String difficulty;		// 난이도
	private String savePath;		// 이미지 저장 경로
	private String createdDate;		// 모임 개설 신청일
	private String openDate;		// 정식 개설일
	
	private int currentMemberCount;	// 현재 멤버 인원수

	public String getGroupApplyCode()
	{
		return groupApplyCode;
	}

	public void setGroupApplyCode(String groupApplyCode)
	{
		this.groupApplyCode = groupApplyCode;
	}

	public String getProposerCode()
	{
		return proposerCode;
	}

	public void setProposerCode(String proposerCode)
	{
		this.proposerCode = proposerCode;
	}

	public String getGroupTitle()
	{
		return groupTitle;
	}

	public void setGroupTitle(String groupTitle)
	{
		this.groupTitle = groupTitle;
	}

	public String getGroupContent()
	{
		return groupContent;
	}

	public void setGroupContent(String groupContent)
	{
		this.groupContent = groupContent;
	}

	public String getTopicType()
	{
		return topicType;
	}

	public void setTopicType(String topicType)
	{
		this.topicType = topicType;
	}

	public String getTopic()
	{
		return topic;
	}

	public void setTopic(String topic)
	{
		this.topic = topic;
	}

	public String getYouthFriendlyType()
	{
		return youthFriendlyType;
	}

	public void setYouthFriendlyType(String youthFriendlyType)
	{
		this.youthFriendlyType = youthFriendlyType;
	}

	public String getYouthFriendly()
	{
		return youthFriendly;
	}

	public void setYouthFriendly(String youthFriendly)
	{
		this.youthFriendly = youthFriendly;
	}

	public String getGenderType()
	{
		return genderType;
	}

	public void setGenderType(String genderType)
	{
		this.genderType = genderType;
	}

	public String getGender()
	{
		return gender;
	}

	public void setGender(String gender)
	{
		this.gender = gender;
	}

	public String getQuestionCode()
	{
		return questionCode;
	}

	public void setQuestionCode(String questionCode)
	{
		this.questionCode = questionCode;
	}

	public String getQuestion()
	{
		return question;
	}

	public void setQuestion(String question)
	{
		this.question = question;
	}

	public String getRule()
	{
		return rule;
	}

	public void setRule(String rule)
	{
		this.rule = rule;
	}

	public int getKickOut()
	{
		return kickOut;
	}

	public void setKickOut(int kickOut)
	{
		this.kickOut = kickOut;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
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

	public int getMaxCount()
	{
		return maxCount;
	}

	public void setMaxCount(int maxCount)
	{
		this.maxCount = maxCount;
	}

	public String getRegion()
	{
		return region;
	}

	public void setRegion(String region)
	{
		this.region = region;
	}

	public String getOnOffType()
	{
		return onOffType;
	}

	public void setOnOffType(String onOffType)
	{
		this.onOffType = onOffType;
	}

	public String getOnOff()
	{
		return onOff;
	}

	public void setOnOff(String onOff)
	{
		this.onOff = onOff;
	}

	public String getFrequencyType()
	{
		return frequencyType;
	}

	public void setFrequencyType(String frequencyType)
	{
		this.frequencyType = frequencyType;
	}

	public String getFrequency()
	{
		return frequency;
	}

	public void setFrequency(String frequency)
	{
		this.frequency = frequency;
	}

	public String getDifficultyType()
	{
		return difficultyType;
	}

	public void setDifficultyType(String difficultyType)
	{
		this.difficultyType = difficultyType;
	}

	public String getDifficulty()
	{
		return difficulty;
	}

	public void setDifficulty(String difficulty)
	{
		this.difficulty = difficulty;
	}

	public String getSavePath()
	{
		return savePath;
	}

	public void setSavePath(String savePath)
	{
		this.savePath = savePath;
	}

	public String getCreatedDate()
	{
		return createdDate;
	}

	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}

	public String getOpenDate()
	{
		return openDate;
	}

	public void setOpenDate(String openDate)
	{
		this.openDate = openDate;
	}

	public int getCurrentMemberCount()
	{
		return currentMemberCount;
	}

	public void setCurrentMemberCount(int currentMemberCount)
	{
		this.currentMemberCount = currentMemberCount;
	}
	
}