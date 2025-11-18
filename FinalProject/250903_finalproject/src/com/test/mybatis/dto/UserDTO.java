package com.test.mybatis.dto;

public class UserDTO
{
	// USER_INFO 테이블 속성
	private String userId, password, userName, nickname, userCode
	, ssn1, ssn2, email, address, zipCode, savePath, createdDate
	, myGroup, joinGroup, requestJoin, requestApply, quitGroup, gender, age;

	// getter / setter 구성
	public String getUserId()
	{
		return userId;
	}

	public String getGender()
	{
		return gender;
	}

	public void setGender(String gender)
	{
		this.gender = gender;
	}

	public String getAge()
	{
		return age;
	}

	public void setAge(String age)
	{
		this.age = age;
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

	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}

	public String getUserCode()
	{
		return userCode;
	}

	public void setUserCode(String userCode)
	{
		this.userCode = userCode;
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

	public String getCreatedDate()
	{
		return createdDate;
	}

	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}

	public String getMyGroup()
	{
		return myGroup;
	}

	public void setMyGroup(String myGroup)
	{
		this.myGroup = myGroup;
	}

	public String getJoinGroup()
	{
		return joinGroup;
	}

	public void setJoinGroup(String joinGroup)
	{
		this.joinGroup = joinGroup;
	}

	public String getRequestJoin()
	{
		return requestJoin;
	}

	public void setRequestJoin(String requestJoin)
	{
		this.requestJoin = requestJoin;
	}

	public String getRequestApply()
	{
		return requestApply;
	}

	public void setRequestApply(String requestApply)
	{
		this.requestApply = requestApply;
	}

	public String getQuitGroup()
	{
		return quitGroup;
	}

	public void setQuitGroup(String quitGroup)
	{
		this.quitGroup = quitGroup;
	}
}
