package com.test.mybatis.dao;

import org.apache.ibatis.annotations.Mapper;

import com.test.mybatis.dto.UserDTO;

@Mapper
public interface ILoginDAO
{
	public UserDTO loginProcess(UserDTO user);
}
