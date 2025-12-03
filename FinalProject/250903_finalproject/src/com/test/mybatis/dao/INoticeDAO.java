package com.test.mybatis.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.NoticeDTO;

public interface INoticeDAO
{
	// 매니저(관리자)가 보는 공지 리스트
	public List<NoticeDTO> noticeListForManager(@Param("start") int start, @Param("end") int end);

	// select -> 전체 리스트 개수 조회
	public int listCount();
	
	// select -> 공지 상세보기
	public NoticeDTO noticeDetailForManager(@Param("noticecode") String noticecode);
	
}
