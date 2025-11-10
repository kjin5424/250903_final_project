package com.test.mybatis.dto;

public class MessageDTO
{
	private String messageCode;		// 메세지 코드
	private String forwarder;		// 보낸 joinCode
	private String receiver;		// 받은 joinCode
	private String nickName;		// 닉네임
	private String content;			// 메세지 내용
	private String createdDate;		// 메세지 작성일자
	private String readDate;		// 메세지 읽은날짜
	private String fdeleteDate;		// 발신자 메세지 삭제일자
	private String rdeleteDate;		// 수신자 메세지 삭제일자
	private String position;		// Order By용 position
	private String savePath;		// 프사
	
	public String getMessageCode()
	{
		return messageCode;
	}
	public void setMessageCode(String messageCode)
	{
		this.messageCode = messageCode;
	}
	public String getForwarder()
	{
		return forwarder;
	}
	public void setForwarder(String forwarder)
	{
		this.forwarder = forwarder;
	}
	public String getReceiver()
	{
		return receiver;
	}
	public void setReceiver(String receiver)
	{
		this.receiver = receiver;
	}
	public String getNickName()
	{
		return nickName;
	}
	public void setNickName(String nickName)
	{
		this.nickName = nickName;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getCreatedDate()
	{
		return createdDate;
	}
	public void setCreatedDate(String createdDate)
	{
		this.createdDate = createdDate;
	}
	public String getReadDate()
	{
		return readDate;
	}
	public void setReadDate(String readDate)
	{
		this.readDate = readDate;
	}
	public String getPosition()
	{
		return position;
	}
	public void setPosition(String position)
	{
		this.position = position;
	}
	public String getFdeleteDate()
	{
		return fdeleteDate;
	}
	public void setFdeleteDate(String fdeleteDate)
	{
		this.fdeleteDate = fdeleteDate;
	}
	public String getRdeleteDate()
	{
		return rdeleteDate;
	}
	public void setRdeleteDate(String rdeleteDate)
	{
		this.rdeleteDate = rdeleteDate;
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
