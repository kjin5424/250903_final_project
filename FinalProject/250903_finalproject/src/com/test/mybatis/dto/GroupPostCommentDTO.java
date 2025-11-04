package com.test.mybatis.dto;

public class GroupPostCommentDTO
{
	String commentCode;		// 댓글 코드
	String nickName;		// 작성자 닉네임
	String createdDate;		// 작성일
	String updatedDate;		// 수정일
	String content;			// 내용
	String savePath;		// 댓글 작성자 프사 
	boolean isBlinded;		// 블라인드 처리 여부
	
	public String getCommentCode()
	{
		return commentCode;
	}
	public void setCommentCode(String commentCode)
	{
		this.commentCode = commentCode;
	}
	public String getNickName()
	{
		return nickName;
	}
	public void setNickName(String nickName)
	{
		this.nickName = nickName;
	}
	public String getCreatedDate()
	{
		return createdDate;
	}
	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}
	public String getUpdatedDate()
	{
		return updatedDate;
	}
	public void setUpdatedDate(String updatedDate)
	{
		this.updatedDate = updatedDate;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getSavePath()
	{
		return savePath;
	}
	public void setSavePath(String savePath)
	{
		this.savePath = savePath;
	}
	public boolean isBlinded()
	{
		return isBlinded;
	}
	public void setBlinded(boolean isBlinded)
	{
		this.isBlinded = isBlinded;
	}
	
}
