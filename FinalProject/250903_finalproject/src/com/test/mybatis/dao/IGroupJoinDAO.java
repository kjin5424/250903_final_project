package com.test.mybatis.dao;

import java.util.List;import javax.annotation.security.PermitAll;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.GroupJoinDTO;
import com.test.mybatis.dto.UserDTO;


public interface IGroupJoinDAO
{
	// insert
	// �쑀��媛� �듅�젙 紐⑥엫�뿉 媛��엯 �떊泥��쓣 �븳�떎
	public int insertGroupJoin(GroupJoinDTO dto);
	
	// select -> 媛��엯 �떊泥� �긽�꽭 議고쉶
	// -> 紐⑥엫�옣�씠 �떊泥� �긽�꽭 �궡�뿭�쓣 �솗�씤�븷 �븣
	public List<GroupJoinDTO> selectGroupJoinById(String groupApplyCode);
	
	// select --> �듅�젙 紐⑥엫�쓽 媛��엯 �떊泥��븳 �궗�엺�뱾�쓽 紐⑸줉�쓣 媛��졇�샂
	// -> 紐⑥엫�옣�씠 媛��엯�떊泥� ��湲곗옄 紐⑸줉�쓣 媛��졇�삱 �븣 -> 紐⑥엫�솃�뿉�꽌 愿�由ъ뿉�꽌 �떊泥��꽌 愿�由ы븷 �븣 
	public List<GroupJoinDTO> selectJoinRequestByGroup(String groupApplyCode);
	
	// 媛��엯 �긽�깭 �뾽�뜲�씠�듃(�듅�씫 / 嫄곗젅)
	// -> 紐⑥엫�옣�씠 �듅�씤/嫄곗젅�쓣 泥섎━�븷 �븣
	public int statusGroupJoin(GroupJoinDTO dto);
	
	// select 以묐났 �떊泥� 泥댄겕 
	// �씠誘� �떊泥��븳 �쑀��媛� �삉 �떊泥��븯吏� 紐삵븯寃�
	public int checkDuplicationGroup(@Param("userCode") String userCode, @Param("groupApplyCode") String groupApplyCode);
	
	// select -> �궗�슜�옄媛� ��湲� 以묒씤 �떊泥� �닔 議고쉶
	public int countWatingGroup(String userCode);
	
	// select -> �궗�슜�옄媛� �쁽�옱 媛��엯 �맂 紐⑥엫�쓽 �닔
	public int countGroupJoin(String userCode);
	
	// select -> �궗�슜�옄�쓽 �쟾泥� �떊泥� �궡�뿭 議고쉶
	public List<GroupJoinDTO> selectUserRequest(String userCode);
	
	// select -> 洹� 紐⑥엫�뿉�꽌 �떊泥� ��湲� �씤�썝 �닔
	public int countApplyGroup(String groupJoinCode);
	
	// select -> Home.jsp �뿉�꽌 �궗�슜�븷 �븳 以� �옄湲곗냼媛� 媛��졇�삤湲�
	public GroupJoinDTO getSelfIntro(@Param("groupApplyCode") String groupApplyCode, @Param("userCode") String userCode);
	
	// update -> Home.jsp �뿉�꽌 �븳 以� �옄湲곗냼媛� �닔�젙�븯�뒗 �럹�씠吏�
	public void updateIntroduce(@Param("joinCode") String joinCode, @Param("introduce") String introduce);
	
	public GroupJoinDTO myPageQuitGroup(@Param("userCode") String userCode);
	
}
 