package com.test.mybatis.dto;

public class GroupMemberDTO
{
	private String memberCode;		// 모임원 코드
	private String groupApplyCode;	// 모임 코드
	private String userCode;		// 유저 코드
	private String roleCode;		// 역할 관한 코드(모임장/부모임장/도우미)
	private String selfIntro;		// 모임원 한줄 자기소개서
	private String joinDate;		// 참여일
	private String quitDate;		// 탈퇴일
	private String quitResson;		// 탈퇴 사유
	private String isKicked;		// 강제 탈퇴 여부
	// 강퇴 당한 사유랑 누가 언제 당했는지를 히스토리에 보여줘야 함
	
	// 활동 관련 속성
	private int attendanceCount;	// 출석 횟수
	private int totalMettingCount;	// 전체 모임 활동 횟수

	private int challengeCount;		// 도전과제 참여 횟수
	private int challengeComplete;	// 완료된 도전과제 갯수
	
	
	// 추가 속성
	private String roleName;		// 역할 이름
	
	// getter / setter 
	public String getMemberCode()
	{
		return memberCode;
	}
	public void setMemberCode(String memberCode)
	{
		this.memberCode = memberCode;
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
	public String getRoleCode()
	{
		return roleCode;
	}
	public void setRoleCode(String roleCode)
	{
		this.roleCode = roleCode;
	}
	public String getSelfIntro()
	{
		return selfIntro;
	}
	public void setSelfIntro(String selfIntro)
	{
		this.selfIntro = selfIntro;
	}
	public String getJoinDate()
	{
		return joinDate;
	}
	public void setJoinDate(String joinDate)
	{
		this.joinDate = joinDate;
	}
	public String getQuitDate()
	{
		return quitDate;
	}
	public void setQuitDate(String quitDate)
	{
		this.quitDate = quitDate;
	}
	public String getQuitResson()
	{
		return quitResson;
	}
	public void setQuitResson(String quitResson)
	{
		this.quitResson = quitResson;
	}
	public String getIsKicked()
	{
		return isKicked;
	}
	public void setIsKicked(String isKicked)
	{
		this.isKicked = isKicked;
	}
	public int getAttendanceCount()
	{
		return attendanceCount;
	}
	public void setAttendanceCount(int attendanceCount)
	{
		this.attendanceCount = attendanceCount;
	}
	public int getTotalMettingCount()
	{
		return totalMettingCount;
	}
	public void setTotalMettingCount(int totalMettingCount)
	{
		this.totalMettingCount = totalMettingCount;
	}
	
	public int getChallengeCount()
	{
		return challengeCount;
	}
	public void setChallengeCount(int challengeCount)
	{
		this.challengeCount = challengeCount;
	}
	public int getChallengeComplete()
	{
		return challengeComplete;
	}
	public void setChallengeComplete(int challengeComplete)
	{
		this.challengeComplete = challengeComplete;
	}
	
	public String getRoleName()
	{
		return roleName;
	}
	public void setRoleName(String roleName)
	{
		this.roleName = roleName;
	}
	
	
}




