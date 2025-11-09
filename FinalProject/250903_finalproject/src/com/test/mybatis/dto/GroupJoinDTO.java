/*===================
  GroupJoinDTO.java
 ====================*/
package com.test.mybatis.dto;

public class GroupJoinDTO
{
	private String groupJoinCode;		// 모임 가입 신청 Code
	private String groupApplyCode;		// 어떤 모임에 신청했는지
	private String userCode;			// 누가 신청했는지
	private String nickName;
	private String groupName;			// 신청한 모임 이름

	private String introduce;			// 한 줄 자기소개
	private String questionCode;		// 가입 질문 코드
	private String answer;		// 가입 질문 답변
	private int waitingCount;		// 몇 명 신청했는지
	
	// 추가 속성
	private UserDTO user;				// 신청한 유저 정보
	private GroupDTO group;				// 신청 대상 모임 정보
	private String position;			// 모임 내 역할
	private String totalActivity, attendanceActivity;	// 모임 소속 기간 내 전체 모임 활동과 참여한 활동 횟수		
	private String totalChallenge, checkChallenge;		// 참여했던 도전과제와 완수 도전과제 개수
	private String groupTitle;
	private String quitDate;			// 모임 탈퇴 날짜
	private String quitReason;			// 모임 탈퇴 사유
	
	// 신청 상태 	
	private String status;				// 신청 상태
	private String joinDate;			// 신청 날짜
	private String insertDatae;			// 가입 처리 날짜
	private String location;
	
	public String getNickName() {
		return nickName;
	}
	public int getWaitingCount() {
		return waitingCount;
	}
	public void setWaitingCount(int waitingCount) {
		this.waitingCount = waitingCount;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getQuitReason()
	{
		return quitReason;
	}
	public void setQuitReason(String quitReason)
	{
		this.quitReason = quitReason;
	}
	public String getQuitDate()
	{
		return quitDate;
	}
	public void setQuitDate(String quitDate)
	{
		this.quitDate = quitDate;
	}
	public String getGroupTitle()
	{
		return groupTitle;
	}
	public void setGroupTitle(String groupTitle)
	{
		this.groupTitle = groupTitle;
	}
	public String getPosition()
	{
		return position;
	}
	public void setPosition(String position)
	{
		this.position = position;
	}
	public String getTotalActivity()
	{
		return totalActivity;
	}
	public void setTotalActivity(String totalActivity)
	{
		this.totalActivity = totalActivity;
	}
	public String getAttendanceActivity()
	{
		return attendanceActivity;
	}
	public void setAttendanceActivity(String attendanceActivity)
	{
		this.attendanceActivity = attendanceActivity;
	}
	public String getTotalChallenge()
	{
		return totalChallenge;
	}
	public void setTotalChallenge(String totalChallenge)
	{
		this.totalChallenge = totalChallenge;
	}
	public String getCheckChallenge()
	{
		return checkChallenge;
	}
	public void setCheckChallenge(String checkChallenge)
	{
		this.checkChallenge = checkChallenge;
	}
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
	
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getQuestionCode()
	{
		return questionCode;
	}
	public void setQuestionCode(String questionCode)
	{
		this.questionCode = questionCode;
	}
	
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
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
	
	
	public String getInsertDatae() {
		return insertDatae;
	}
	public void setInsertDatae(String insertDatae) {
		this.insertDatae = insertDatae;
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
