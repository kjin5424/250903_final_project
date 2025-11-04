package com.test.mybatis.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupPostCommentDTO;
import com.test.mybatis.dto.GroupPostDTO;

public interface IGroupPostDAO
{
	// select -> 전체 리스트 조회
	public List<GroupPostDTO> list(@Param("start") int start, @Param("end") int end);
	
	// select -> 전체 리스트 개수 조회
	public int listCount();
	
	// select -> 상단 고정 공지 조회
	public List<GroupPostDTO> noticeList();
	
	// select -> 검색 결과 리스트 조회
	public List<GroupPostDTO> searchList(String searchType, String searchKeyword, @Param("start") int start, @Param("end") int end);

	// select -> 검색결과 리스트 개수 조회
	public int searchListCount(String searchType, String searchKeyword);
	
	// select -> 게시글 내용 조회
	public GroupPostDTO postDetail(String postCode);
	
	// insert -> 게시글 작성
	public int insertPost(GroupPostDTO dto);
	
	// update -> 게시글 수정
	public int updatePost(GroupPostDTO dto);
	
	// delete -> 게시글 삭제
	public int deletePost(GroupPostDTO dto);
	
	// select -> 해당 게시글 댓글 조회
	public List<GroupPostCommentDTO> commentList(String postCode);
	
	// insert -> 댓글 작성
	public int insertComment(GroupPostCommentDTO dto);
	
	// update -> 댓글 수정
	public int updateComment(GroupPostCommentDTO dto);
	
	// delete -> 댓글 삭제
	public int deleteComment(GroupPostCommentDTO dto);
}
