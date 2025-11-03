package com.test.mybatis.dao;

import com.test.mybatis.dto.UserDTO;

public interface ILoginDAO
{	
	public UserDTO loginProcess(UserDTO user);
	
	public int validId(String uid);
	
	public int validNickname(String nickname);
	
	public int validEmail(String email);
	
	public int signUpProcess(UserDTO user);
}
