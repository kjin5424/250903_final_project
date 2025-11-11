package com.test.mybatis.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupLevelDTO;

public interface IGroupLevelDAO
{
	// 레벨 타입에 대한 범례를 뽑아오는 메소드
	// 레벨타입별 인원수
	public List<GroupLevelDTO> getType();
	
	// 해당 groupApplyCode의 그룹의 레벨이 몇인지
	public String whatLevel(@Param("groupApplyCode") String groupApplyCode);
	
	// 해당 groupApplyCode의 그룹이 성사된 투표의 개수를 알아내는 메소드
	
	// 해당 groupApplyCode의 그룹의 끝난 도전 과제 개수를 알아내는 메소드
	
	// 조건 만족 후
	// LEVEL_TABLE에 groupApplyCode와 levelType 적용 
}
