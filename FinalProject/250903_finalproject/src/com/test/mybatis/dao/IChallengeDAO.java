package com.test.mybatis.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.ChallengeContentDTO;
import com.test.mybatis.dto.ChallengeDTO;
import com.test.mybatis.dto.GroupJoinDTO;

public interface IChallengeDAO
{
	// select → Home.jsp 에서 사용될 특정 유저의 특정 모임 내 참여 도전과제 출력
	public ChallengeDTO challengeAtHome(@Param("groupApplyCode") String groupApplyCode, @Param("userCode") String userCode);
	
	// select → 모임 내부에서 사용될 특정 모임의 전체 도전과제 출력 메소드
	public List<ChallengeDTO> challengeForGroup(@Param("groupApplyCode") String groupApplyCode);
	
	// joinCode 가져오기.
	public ArrayList<String> getJoinCode(String userCode);
	
	// 모임에 맞는 challenge 가져오기.
	public ArrayList<ChallengeDTO> challengeList(String groupApplyCode);
	
	// 도전과제 세부 사항 가져오기.
	public ChallengeDTO getChallengeDetail(String challengeCode);
	
	// 도전과제 세부 사항 > 내용 가져오기.
	public ArrayList<ChallengeContentDTO> getChallengeContent(String challengeCode);
}
