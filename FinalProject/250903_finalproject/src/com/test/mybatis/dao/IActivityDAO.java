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
	public int countActivity(@Param("groupApplyCode") String groupApplyCode);
	
}
