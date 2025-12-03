package com.test.mybatis.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.ActivityDTO;

public interface IActivityDAO
{
	// 특정 활동 한개에 대한 내용을 출력하는 메소드
	public ActivityDTO activityDetail(String activityCode);
	
	// 특정 그룹의 모든 활동을 보는 메소드
	public ArrayList<ActivityDTO> activityForGroup(@Param("activityDTO") ActivityDTO activityDTO);
	
	// 특정 그룹의 모임 홈 화면에서 출력할 미래의 활동 중 가장 최근 값 2개만 출력하는 메소드
	public ArrayList<ActivityDTO> activityListAtHome(@Param("groupApplyCode") String groupApplyCode);
	
	// 특정 모임의 전체 활동 개수 출력하는 메소드
	public Integer countActivity(@Param("groupApplyCode") String groupApplyCode);
	
	// 특정 모임의 활동 한 개를 등록하는 메소드
	public void addActivity(@Param("dto") ActivityDTO activityDTO);
	
	// 현재 사용자의 특정 활동에 대한 투표 상태 조회
	public Integer getMyVoteStatus(@Param("activityCode") String activityCode, @Param("joinCode") String joinCode);
	
	// 투표 제출/수정
	public void submitVote(@Param("activityCode") String activityCode, @Param("joinCode") String joinCode, @Param("yOrNType") Integer yOrNType);
	
	// 활동 삭제
	public void deleteActivity(@Param("activityCode") String activityCode);
	
}
