package com.test.mybatis.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.ChallengeContentDTO;
import com.test.mybatis.dto.ChallengeInfoDTO;
import com.test.mybatis.dto.ChallengerDTO;

public interface IChallengeDAO
{
	// select → Home.jsp 에서 사용될 특정 유저의 특정 모임 내 참여 도전과제 출력
	public ChallengeInfoDTO challengeAtHome(@Param("groupApplyCode") String groupApplyCode, @Param("userCode") String userCode);
	
	// select → 모임 내부에서 사용될 특정 모임의 전체 도전과제 출력 메소드
	public List<ChallengeInfoDTO> challengeForGroup(@Param("groupApplyCode") String groupApplyCode);
	
	// 유저가 속한 groupApplyCode 가져오기
	public ArrayList<String> getGroupApplyCodes(String UserCode);
	
	// 모임에 맞는 challenge 가져오기.
	public ArrayList<ChallengeInfoDTO> challengeList(String groupApplyCode);
	
	// nickname 가져오기
	public String getNickname(String joinCode);
	
	// joinCode 가져오기
	public String getJoinCodeFromUCGA(@Param("userCode")String userCode, @Param("groupApplyCode")String groupApplyCode);
	
	// 도전과제 등록하기
	public void challengeCreate(ChallengeContentDTO dto);
	
	// 도전과제 세부 사항 가져오기
	public ChallengeInfoDTO getChallengeDetail(String challengeCode);
	
	// 도전과제 세부 사항 > 내용 가져오기
	public ArrayList<ChallengeContentDTO> getChallengeContent(String challengeCode);
	
	// 도전과제 달성자 정보 가져오기
	public ArrayList<ChallengerDTO> getChallengerInfo(String challengeCode);
	
	// 도전과제 달성 날짜 가져오기
	public String getSuccessDate(@Param("joinCode")String joinCode, @Param("challengeCode")String challengeCode);
	
	// challengeCode로 groupApplyCode 조회
	public String getGroupApplyCodeByChallengeCode(String challengeCode);
	
	// challengeMemberCode 조회
	public String getChallengeMemberCode(@Param("challengeCode")String challengeCode, @Param("joinCode")String joinCode);
	
	// 체크된 challengeDetailCode 목록 조회
	public ArrayList<String> getCheckedDetailCodes(String challengeMemberCode);
	
	// CHALLENGE_CHECK INSERT
	public void insertChallengeCheck(@Param("challengeMemberCode")String challengeMemberCode, @Param("challengeDetailCode")String challengeDetailCode);
	
	// CHALLENGE_CHECK DELETE
	public void deleteChallengeCheck(@Param("challengeMemberCode")String challengeMemberCode, @Param("challengeDetailCode")String challengeDetailCode);
}
