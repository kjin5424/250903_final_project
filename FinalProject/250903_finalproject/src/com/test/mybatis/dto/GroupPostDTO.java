package com.test.mybatis.dto;

public class GroupPostDTO
{
	private String postCode;				// 게시글 코드
	private String boardCategory;			// 게시글 카테고리
	private String subject;					// 게시글 제목
	private String content;					// 게시글 내용
	private String nickName;				// 게시글 작성자 닉네임
	private String joinCode;				// 게시글 작성자 회원 코드 
	private String groupApplyCode;			// 게시글 작성된 모임 코드
	private String createdDate;				// 게시글 작성 일자
	private String updatedDate;				// 게시글 수정 일자
	private String savePath;				// 게시글 작성자 프사
	private boolean isBlinded;				// 블라인드 처리 여부
	private int commentCount;				// 게시글에 작성된 댓글 수
	private int totalCount;					// 총 게시글 개수
	
	
	public String getPostCode()
	{
		return postCode;
	}
	public void setPostCode(String postCode)
	{
		this.postCode = postCode;
	}
	public String getBoardCategory()
	{
		return boardCategory;
	}
	public void setBoardCategory(String boardCategory)
	{
		this.boardCategory = boardCategory;
	}
	public String getSubject()
	{
		return subject;
	}
	public void setSubject(String subject)
	{
		this.subject = subject;
	}
	public String getNickName()
	{
		return nickName;
	}
	public void setNickName(String nickName)
	{
		this.nickName = nickName;
	}
	public String getJoinCode()
	{
		return joinCode;
	}
	public void setJoinCode(String joinCode)
	{
		this.joinCode = joinCode;
	}
	public String getGroupApplyCode()
	{
		return groupApplyCode;
	}
	public void setGroupApplyCode(String groupApplyCode)
	{
		this.groupApplyCode = groupApplyCode;
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
	public String getSavePath()
	{
		return savePath;
	}
	public void setSavePath(String savePath)
	{
		this.savePath = savePath;
	}
	public int getCommentCount()
	{
		return commentCount;
	}
	public void setCommentCount(int commentCount)
	{
		this.commentCount = commentCount;
	}
	public boolean isBlinded()
	{
		return isBlinded;
	}
	public void setBlinded(boolean isBlinded)
	{
		this.isBlinded = isBlinded;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public int getTotalCount()
	{
		return totalCount;
	}
	public void setTotalCount(int totalCount)
	{
		this.totalCount = totalCount;
	}
	
	
}
