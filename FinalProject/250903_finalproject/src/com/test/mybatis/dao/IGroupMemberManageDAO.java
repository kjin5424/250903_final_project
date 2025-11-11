package com.test.mybatis.dao;

import java.util.List;

import com.test.mybatis.dto.GroupMemberManageDTO;

public interface IGroupMemberManageDAO
{
	// 탈퇴 사유
	public List<GroupMemberManageDTO> quitReason(String quitType);
	
	// 탈퇴 회원 insert
	public int insertquitmember(GroupMemberManageDTO dto);
}
