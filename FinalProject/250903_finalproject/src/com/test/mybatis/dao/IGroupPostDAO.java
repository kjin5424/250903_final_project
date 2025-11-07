package com.test.mybatis.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupPostCommentDTO;
import com.test.mybatis.dto.GroupPostDTO;

public interface IGroupPostDAO
{
	// select -> 전체 리스트 조회
	public List<GroupPostDTO> list(@Param("groupApplyCode") String groupApplyCode
								 , @Param("start") int start
								 , @Param("end") int end);
	
	// select -> 전체 리스트 개수 조회
	public int listCount(@Param("groupApplyCode") String groupApplyCode);
	
	// select -> 상단 고정 공지 조회
	public List<GroupPostDTO> noticeList(@Param("groupApplyCode") String groupApplyCode);
	
	// select -> 검색 결과 리스트 조회
	public List<GroupPostDTO> searchList(@Param("groupApplyCode") String groupApplyCode
									   , @Param("searchType") String searchType
									   , @Param("searchKeyword") String searchKeyword
									   , @Param("start") int start
									   , @Param("end") int end);

	// select -> 검색결과 리스트 개수 조회
	public int searchListCount(@Param("groupApplyCode") String groupApplyCode
			  				 , @Param("searchType") String searchType
			  				 , @Param("searchKeyword") String searchKeyword);
	
	// select -> 게시글 내용 조회
	public GroupPostDTO postDetail(String postCode);
	
	// insert -> 게시글 작성
	public int insertPost(GroupPostDTO dto);
	
	// update -> 게시글 수정
	public int updatePost(GroupPostDTO dto);
	
	// delete -> 게시글 삭제
	public int deletePost(String postCode);
	
	// select -> 해당 게시글 댓글 조회
	public List<GroupPostCommentDTO> commentList(String postCode);
	
	// insert -> 댓글 작성
	public int insertComment(GroupPostCommentDTO dto);
	
	// update -> 댓글 수정
	public int updateComment(GroupPostCommentDTO dto);
	
	// delete -> 댓글 삭제
	public int deleteComment(GroupPostCommentDTO dto);
	
	// select -> Home.jsp 에서 사용할 공지 게시글만 가져오기
	public List<GroupPostDTO> postListAtHome(@Param("groupApplyCode") String groupApplyCode);
	
	// select -> 모임원 권한 확인
	public String validateMember(@Param("joinCode") String joinCode);
	
	// select -> joinCode 확인
	public String getJoinCode(@Param("groupApplyCode") String groupApplyCode
							, @Param("userCode") String userCode);

}
