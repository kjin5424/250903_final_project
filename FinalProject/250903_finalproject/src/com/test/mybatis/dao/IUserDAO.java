package com.test.mybatis.dao;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.UserDTO;

public interface IUserDAO
{
	// 내 프로필 열람
	public UserDTO myProfile(String userCode);
	
	// 모임장이 아닌 타회원이 열람하는 타회원 프로필
	public UserDTO otherProfile(String userCode);
	
	// 조회자와 조회 대상자 간 관계를 증명하는 메소드
	public int relationCheck(@Param("readerUserCode") String readerUserCode,@Param("targetUserCode") String targetUserCode);
	
	// 현재 운영/참여중인 모임 리스트 조회하는 메소드
	public GroupDTO currentGroupList(@Param("userCode") String userCode);
	
	// 과거 운영/참여중인 모임 리스트 조회하는 메소드
	public GroupDTO quitGroupList(@Param("userCode") String userCode);
	
}
