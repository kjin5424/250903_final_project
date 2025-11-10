package com.test.mybatis.dao;

import java.util.List;

import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.GroupMemberDTO;

public interface IGroupMemberDAO
{
	// insert -> 모임원 가입 승락시
	public int insertMember(GroupMemberDTO dto);
	
	// select -> 전체 모임원 보여주는 리스트
	public List<GroupMemberDTO> selectTotalMember(String groupApplyCode);
	
	// select -> 특정 모임원 상세 정보 조회
	// 이거 프로필이라 삭제 예정
	public GroupMemberDTO selectMemberDetail(String memberCode);
	
	// select -> 특정 모임의 전체 가입 목록 조회(현재 활동 등)
	// 특정 모임이 아니라 모임원
	public List<GroupMemberDTO> selectGroupByAction(String userCode);
	
	// select -> 특정 유저의 탈퇴 회원 목록 조회
	public List<GroupMemberDTO> selectQuitGroup(String userCode);
	
	// select -> 특정 모임의 모임장 정보 조회
	// 삭제
	public GroupMemberDTO selectLeaderGroup(String groupApplyCode);
	
	// select -> 특정 모임의 부모임장 정보 조회
	// 삭제
	public GroupMemberDTO selectSubLeaderGroup(String groupApplyCode);
	
	// select -> 특정 모임의 도우미 정보 조회
	// 삭제
	public GroupMemberDTO selectHelperGroup(String groupApplyCode);
	
	// select -> 유저가 특정 모임의 모임원인지
	// 삭제
	public int checkMemberGroup(String userCode, String groupApplyCode);
	
	// select -> 특정 모임의 총 인원 수
	// 삭제
	public int countTotalGroupMember(String groupApplyCode);
	
	// select -> 특정 모임의 가입한 총 인원 수
	public int countTotalSpecificGroupMember(String userCode);
	
	// select -> 특정 모임의 출석률 조회
	public double selectAttendenceRate(String memberCode);
	
	// select -> 특정 모임의 도전과제 달성율 조회
	public double selectChallengeRate(String memberCode);
	
	// update -> 모임원 역할 변경(모임장, 부모임장, 도우미)
	public int updateMemberRole(GroupMemberDTO dto);
	
	// update -> 한 줄 자기소개서 수정
	public int updateselfIntro(GroupMemberDTO dto);
	
	// 모임원 탈퇴 처리(탈퇴일, 탈퇴 사유)
	public int updateQuitGroup(GroupMemberDTO dto);
	
	// 강제 탈퇴
	public int updateForcingGroup(GroupMemberDTO dto);
	
	// 출석 정보 업데이트
	// ACTIVITY DTO 랑 DAO 만들어서 관리해야하기 때문에 추후에 삭제
	public int updateAttendanceGroup(GroupMemberDTO dto);
	
	// 도전 과제 참여 / 완료 업데이트
	// CHALLENGE DTO 랑 DAO 만들어서 관리해야하기 때문에 추후에 삭제
	public int updateChallengeComplete(GroupMemberDTO dto);
	
	// select -> 특정 모임의 평균 출석률
	// 삭제
	public double selectAverageGroup(String groupApplyCode);
	
	// select -> 특정 모임의 도전과제 달성률 조회
	public double selectAverageChallenge(String groupApplyCode);
	
	// 모임장 자동 이양(한달 미접속 시)
	public int updateLeaderTransfer(String groupApplyCode, String newLeaderCode);
	
	// 모임 정보 수정
	public void updateGroup(GroupDTO dto);
}




























