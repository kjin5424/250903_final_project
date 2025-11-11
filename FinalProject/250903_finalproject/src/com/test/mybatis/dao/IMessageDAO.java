package com.test.mybatis.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.MessageDTO;

public interface IMessageDAO
{
	// 쪽지 작성 페이지에서 멤버 리스트 가져오기
	public ArrayList<MessageDTO> getUserList(@Param("groupApplyCode") String groupApplyCode);
	
	// 쪽지 조회 페이지에서 받은 편지함 가져오기
	public ArrayList<MessageDTO> getReceivedMessage(@Param("groupApplyCode") String groupApplyCode
											, @Param("joinCode") String joinCode);
	
	// 쪽지 조회 페이지에서 보낸 편지함 가져오기
	public ArrayList<MessageDTO> getForwardedMessage(@Param("groupApplyCode") String groupApplyCode
											, @Param("joinCode") String joinCode);										
	// 쪽지 DB에 작성하기
	public int sendMessage(MessageDTO dto);
	
	// 쪽지 읽음 처리
	public int readMessage(@Param("messageCode") String messageCode);
	
}
