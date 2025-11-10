package com.test.mybatis.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.HistoryDTO;

public interface IHistoryDAO
{
	// 모임 히스토리 (History.jsp) 페이지에서 쓰는 전체 히스토리 출력 메소드
	public List<HistoryDTO> getHistory(@Param("groupApplyCode")String groupApplyCode);
	
	// 모임 및 권한 탭에서 쓰일 히스토리 출력 메소드
	public List<HistoryDTO> notLevelHistory(@Param("groupApplyCode")String groupApplyCode);
	
	// 레벨 탭에서 쓰일 히스토리 출력 메소드
	public List<HistoryDTO> levelHistory(@Param("groupApplyCode")String groupApplyCode);
	
	// 전체 탭에서 쓰일 모임의 총 활동 횟수를 구하는 메소드
	public Integer countActivity(@Param("groupApplyCode") String groupApplyCode);
	
	// 전체 탭에서 쓰일 모임의 현재 레벨 구하는 메소드
	public String currentLevel(@Param("groupApplyCode")String groupApplyCode);
	
	// 전체 탭에서 쓰일 완료 도전과제 달성 개수 구하는 메소드
	public Integer countChallenge(@Param("groupApplyCode")String groupApplyCode);
}
