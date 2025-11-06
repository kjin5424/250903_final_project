package com.test.mybatis.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.ChallengeDTO;

public interface IChallengeDAO
{
	// select → Home.jsp 에서 사용될 특정 유저의 특정 모임 내 참여 도전과제 출력
	public ChallengeDTO challengeAtHome(@Param("groupApplyCode") String groupApplyCode, @Param("userCode") String userCode);
	
	// select → 모임 내부에서 사용될 특정 모임의 전체 도전과제 출력 메소드
	public List<ChallengeDTO> challengeForGroup(@Param("groupApplyCode") String groupApplyCode);
}
