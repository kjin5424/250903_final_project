package com.test.mybatis.dto;

import java.util.List;

public class SearchDTO
{
	private String content;
	private List<String> category;
	private List<String> region;
	private List<String> type;
	private List<String> status;
	
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public List<String> getCategory()
	{
		return category;
	}
	public void setCategory(List<String> category)
	{
		this.category = category;
	}
	public List<String> getRegion()
	{
		return region;
	}
	public void setRegion(List<String> region)
	{
		this.region = region;
	}
	public List<String> getType()
	{
		return type;
	}
	public void setType(List<String> type)
	{
		this.type = type;
	}
	public List<String> getStatus()
	{
		return status;
	}
	public void setStatus(List<String> status)
	{
		this.status = status;
	}
}