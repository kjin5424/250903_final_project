package com.test.mybatis.dto;

public class LoginLogDTO
{
	// 로그인 이력 테이블 조회시 받아올 로그인로그코드와 로그인 일시
	private String loginLogCode, createdDate;

	// getter / setter 구성
	public String getLoginLogCode()
	{
		return loginLogCode;
	}

	public void setLoginLogCode(String loginLogCode)
	{
		this.loginLogCode = loginLogCode;
	}

	public String getCreatedDate()
	{
		return createdDate;
	}

	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}
	
	
}
