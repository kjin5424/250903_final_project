package com.test.mybatis.dao;

import com.test.mybatis.dto.UserDTO;

public interface ILoginDAO
{	
	public UserDTO loginProcess(UserDTO user);
	
	public int validId(String uid);
	
	public int signUpProcess(UserDTO user);
}
