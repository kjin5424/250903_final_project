package com.test.mybatis.dao;

import com.test.mybatis.dto.UserDTO;

public interface IUserDAO
{
	// 내 프로필 열람
	public UserDTO myProfile(String userCode);
	
	// 모임장이 열람하는 타회원 프로필
	public UserDTO myMemberProfile(String joinCode);
	
	// 모임장이 아닌 타회원이 열람하는 타회원 프로필
	public UserDTO otherProfile(String joinCode);
	
	// 
	
	
}
