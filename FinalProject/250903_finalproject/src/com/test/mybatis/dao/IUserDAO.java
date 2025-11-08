package com.test.mybatis.dao;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.UserDTO;

public interface IUserDAO
{
	// �궡 �봽濡쒗븘 �뿴�엺
	public UserDTO myProfile(String userCode);
	
	// 紐⑥엫�옣�씠 �븘�땶 ���쉶�썝�씠 �뿴�엺�븯�뒗 ���쉶�썝 �봽濡쒗븘
	public UserDTO otherProfile(String userCode);
	
	// 議고쉶�옄�� 議고쉶 ���긽�옄 媛� 愿�怨꾨�� 利앸챸�븯�뒗 硫붿냼�뱶
	public int relationCheck(@Param("readerUserCode") String readerUserCode,@Param("targetUserCode") String targetUserCode);
	
	// �쁽�옱 �슫�쁺/李몄뿬以묒씤 紐⑥엫 由ъ뒪�듃 議고쉶�븯�뒗 硫붿냼�뱶
	public GroupDTO currentGroupList(@Param("userCode") String userCode);
	
	// 怨쇨굅 �슫�쁺/李몄뿬以묒씤 紐⑥엫 由ъ뒪�듃 議고쉶�븯�뒗 硫붿냼�뱶
	public GroupDTO quitGroupList(@Param("userCode") String userCode);
	
	// 紐⑥엫 而⑦뀗痢� �깮�궛 �뤌 �슂泥� �떆 �빐�떦 �쑀��媛� �빐�떦 紐⑥엫�쓽 紐⑥엫�썝�씤吏� 寃�利앺븯�뒗 硫붿냼�뱶
	public String checkMember(@Param("userCode") String userCode, @Param("groupApplyCode") String groupApplyCode);
	
	public UserDTO myPage(@Param("userCode") String userCode);
}
