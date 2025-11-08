package com.test.mybatis.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.SearchDTO;

public interface IGroupDAO
{
	// 紐⑥엫 由ъ뒪�듃 議고쉶(寃��깋 X)
	public ArrayList<GroupDTO> groupList(String category);
	
	// �쁽�옱 �씤�썝 �닔 �궛異�
	public int groupMemberCount(String groupApplyCode);
	
	// 紐⑥엫 由ъ뒪�듃 寃��깋�쑝濡� 議고쉶
	public ArrayList<GroupDTO> searchList(SearchDTO dto);
	
	// 紐⑥엫 �긽�꽭 �궡�슜(留ㅺ컻蹂��닔濡� 紐⑥엫媛쒖꽕肄붾뱶)
	public GroupDTO groupDetail(String groupApplyCode);
	
	// 紐⑥엫 媛쒖꽕 �떊泥�
	public void groupApply(GroupDTO dto);
	
	// 紐⑥엫 �궡�슜 �닔�젙
	public String groupModify(GroupDTO dto);
	
	// �궗�슜�옄�쓽 �쟾泥� �떊泥� �궡�뿭 議고쉶
	
	// 紐⑥엫 �솃�뿉�꽌 異쒕젰�븷 �궡�슜�뱾
	public GroupDTO groupHomeGroupInfo(@Param("userCode") String userCode,@Param("groupApplyCode") String groupApplyCode);
	
	// �듅�젙 �쉶�썝�씠 �듅�젙 紐⑥엫�쓽 紐⑥엫�썝�씤吏� 寃�利앺븯�뒗 硫붿냼�뱶
	public String checkMember(@Param("groupApplyCode") String groupApplyCode, @Param("userCode") String userCode);
	
	public GroupDTO myPageMyGroup(@Param("userCode") String userCode);

	public GroupDTO myPageJoinGroup(@Param("userCode") String userCode);
	
	public GroupDTO myPageRequestJoinGroup(@Param("userCode") String userCode);
	
	public GroupDTO myPageRequestApplyGroup(@Param("userCode") String userCode);
	
	public GroupDTO myPageFavoriteGroup(@Param("userCode") String userCode);
}
