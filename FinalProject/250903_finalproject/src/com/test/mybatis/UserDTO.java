package com.test.mybatis;

public class UserDTO
{
	private String userId, password, nickName
	, ssn1, ssn2, email, address, zipCode, savePath;

	
	public String getUserId()
	{
		return userId;
	}

	public void setUserId(String userId)
	{
		this.userId = userId;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getNickName()
	{
		return nickName;
	}

	public void setNickName(String nickName)
	{
		this.nickName = nickName;
	}

	public String getSsn1()
	{
		return ssn1;
	}

	public void setSsn1(String ssn1)
	{
		this.ssn1 = ssn1;
	}

	public String getSsn2()
	{
		return ssn2;
	}

	public void setSsn2(String ssn2)
	{
		this.ssn2 = ssn2;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getZipCode()
	{
		return zipCode;
	}

	public void setZipCode(String zipCode)
	{
		this.zipCode = zipCode;
	}

	public String getSavePath()
	{
		return savePath;
	}

	public void setSavePath(String savePath)
	{
		this.savePath = savePath;
	}

}
