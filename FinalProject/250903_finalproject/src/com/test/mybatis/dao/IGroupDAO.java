package com.test.mybatis.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.SearchDTO;

public interface IGroupDAO
{
	// 모임 리스트 조회(검색 X)
	public ArrayList<GroupDTO> groupList(String category);
	
	// 현재 인원 수 산출
	public int groupMemberCount(String groupApplyCode);
	
	// 모임 리스트 검색으로 조회
	public ArrayList<GroupDTO> searchList(SearchDTO dto);
	
	// 모임 상세 내용(매개변수로 모임개설코드)
	public GroupDTO groupDetail(String groupApplyCode);
	
	// 모임 개설 신청
	public void groupApply(GroupDTO dto);
	
	// 모임 내용 수정
	public String groupModify(GroupDTO dto);
	
	// 사용자의 전체 신청 내역 조회
	
	// 모임 홈에서 출력할 내용들
	public GroupDTO groupHomeGroupInfo(@Param("userCode") String userCode,@Param("groupApplyCode") String groupApplyCode);
	
	// 특정 회원이 특정 모임의 모임원인지 검증하는 메소드
	public int checkMember(@Param("groupApplyCode") String groupApplyCode, @Param("userCode") String userCode);
	
	// 특정 그룹의 비밀번호만 조회하는  메서드
	public String groupPassword(String groupApplyCode);
			
	// 특정 모임의 모임원 리스트(닉네임, 한줄 자기소개) 프로필 빼고
	public List<GroupDTO> groupUserList(String groupApplyCode);
		
	// 특정 모임의 가입질문과 규칙
	public GroupDTO groupQuestionRule(@Param("groupApplyCode") String groupApplyCode);
	
	// 누적 활동 수 구하기
	public int countActivity(@Param("groupApplyCode") String groupApplyCode);
}
