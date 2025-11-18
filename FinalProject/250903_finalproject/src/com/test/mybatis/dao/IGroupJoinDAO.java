package com.test.mybatis.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.GroupJoinDTO;
import com.test.mybatis.dto.UserDTO;


public interface IGroupJoinDAO
{
	// insert
	// 유저가 특정 모임에 가입 신청을 한다
	public int insertGroupJoin(GroupJoinDTO dto);
	
	// select -> 가입 신청 상세 조회
	// -> 모임장이 신청 상세 내역을 확인할 때
	public List<GroupJoinDTO> selectGroupJoinById(@Param("groupApplyCode") String groupApplyCode);
	
	// 대기중인 신청 수
	public int countWaitingGroupMember(String quitType);
	
	// select --> 특정 모임의 가입 신청한 사람들의 목록을 가져옴
	// -> 모임장이 가입신청 대기자 목록을 가져올 때 -> 모임홈에서 관리에서 신청서 관리할 때 
	public List<GroupJoinDTO> selectJoinRequestByGroup(String groupApplyCode);
	
	// 가입 상태 업데이트(승락 / 거절)
	// -> 모임장이 승인/거절을 처리할 때
	public int statusGroupJoin(GroupJoinDTO dto);
	
	// 모임 탈토 사유
	public List<String> quitReason();
	
	// select 중복 신청 체크 
	// 이미 신청한 유저가 또 신청하지 못하게
	public int checkDuplicationGroup(@Param("userCode") String userCode, @Param("groupApplyCode") String groupApplyCode);
	
	// select -> 사용자가 대기 중인 신청 수 조회
	public int countWatingGroup(String userCode);
	
	// select -> 사용자가 현재 가입 된 모임의 수
	public int countGroupJoin(String userCode);
	
	// select -> 사용자의 전체 신청 내역 조회
	public List<GroupJoinDTO> selectUserRequest(String userCode);
	
	// select -> 그 모임에서 신청 대기 인원 수
	public int countApplyGroup(String groupJoinCode);
	
	// select -> Home.jsp 에서 사용할 한 줄 자기소개 가져오기
	public GroupJoinDTO getSelfIntro(@Param("groupApplyCode") String groupApplyCode, @Param("userCode") String userCode);
	
	// update -> Home.jsp 에서 한 줄 자기소개 수정하는 페이지
	public void updateIntroduce(@Param("joinCode") String joinCode, @Param("introduce") String introduce);
	
	public GroupJoinDTO myPageQuitGroup(@Param("userCode") String userCode);

	// 매니저(관리자)가 확인하는 특정 유저 정보에서 활용될 목록 유저의 전체 활동 모임 리스트
	public ArrayList<GroupJoinDTO> groupListForManager(@Param("userCode") String userCode);

}	
 