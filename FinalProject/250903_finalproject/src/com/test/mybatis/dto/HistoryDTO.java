package com.test.mybatis.dto;

public class HistoryDTO
{
	private String history;			// 업데이트 된 내용
	private String type;			// 업데이트 된 객체
	private String updateDate;		// 업데이트 된 날짜
	
	// getter / setter 구성
	public String getHistory()
	{
		return history;
	}
	public void setHistory(String history)
	{
		this.history = history;
	}
	public String getType()
	{
		return type;
	}
	public void setType(String type)
	{
		this.type = type;
	}
	public String getUpdateDate()
	{
		return updateDate;
	}
	public void setUpdateDate(String updateDate)
	{
		this.updateDate = updateDate;
	}
	
	
}
