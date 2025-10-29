package com.test.mybatis;

public interface ILoginDAO
{
	public String findId(UserDTO user);
	
	public String loginProcess(UserDTO user);
}
