package com.test.mybatis.dto;

public class NoticeDTO
{
	// 주요 속성 구성
	private String noticeCode, subject, content, createdDate, managerCode;

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	// getter / setter 구성
	public String getNoticeCode()
	{
		return noticeCode;
	}

	public void setNoticeCode(String noticeCode)
	{
		this.noticeCode = noticeCode;
	}

	public String getSubject()
	{
		return subject;
	}

	public void setSubject(String subject)
	{
		this.subject = subject;
	}

	public String getCreatedDate()
	{
		return createdDate;
	}

	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}

	public String getManagerCode()
	{
		return managerCode;
	}

	public void setManagerCode(String managerCode)
	{
		this.managerCode = managerCode;
	}


	
	
}
