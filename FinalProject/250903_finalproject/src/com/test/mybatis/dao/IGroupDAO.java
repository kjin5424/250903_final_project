package com.test.mybatis.dao;

import java.util.ArrayList;

import com.test.mybatis.dto.GroupDTO;

public interface IGroupDAO
{
	// 모임 리스트 조회(검색 X)
	public ArrayList<GroupDTO> groupList();
	
	// 모임 리스트 검색으로 조회
	public ArrayList<GroupDTO> groupList(GroupDTO dto);
	
	// 모임 상세 내용(매개변수로 모임개설코드)
	public GroupDTO groupDetail(String groupApplyCode);
	
	// 모임 개설 신청
	public String groupApply(GroupDTO dto);
	
	// 모임 내용 수정
	public String groupModify(GroupDTO dto);
	
	
	
}
