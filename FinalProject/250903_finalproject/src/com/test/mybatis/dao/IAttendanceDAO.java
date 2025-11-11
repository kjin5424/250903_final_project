package com.test.mybatis.dao;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.AttendanceDTO;

public interface IAttendanceDAO
{
	// 모임원 관리 → 출석 관리에서 특정 활동일을 기준으로 값을 뽑아낼 메소드
	public AttendanceDTO getAttendanceList(@Param("groupApplyCode")String groupApplyCode);
	
	
}
