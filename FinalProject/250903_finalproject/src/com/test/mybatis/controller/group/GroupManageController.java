package com.test.mybatis.controller.group;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.mybatis.dao.IGroupDAO;
import com.test.mybatis.dao.IGroupJoinDAO;
import com.test.mybatis.dao.IGroupMemberDAO;
import com.test.mybatis.dao.IGroupMemberManageDAO;
import com.test.mybatis.dao.IGroupPostDAO;
import com.test.mybatis.dto.GroupDTO;
import com.test.mybatis.dto.GroupJoinDTO;
import com.test.mybatis.dto.GroupMemberManageDTO;
import com.test.mybatis.dto.UserDTO;
import com.test.util.Paging;

@Controller
public class GroupManageController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/managelist.do", method=RequestMethod.GET)
	public String manageList(@RequestParam("groupApplyCode") String groupApplyCode
						   , Model model
						   , HttpServletRequest request)
	{
		// 모임 제목	(groupHomeGroupInfo-GROUPTITLE)
		// maxCount		(groupHomeGroupInfo-CURRENTMEMBERCOUNT)
		// 상한수		(groupHomeGroupInfo-HEADCOUNT)
		// 누적활동		(groupHomeGroupInfo-TOTALACTIVITY)
		// 평균출석률	(groupHomeGroupInfo-TOTALATTENDANCE)
		// 모임레벨		(groupHomeGroupInfo-GROUPLEVEL)
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("user");
		if (user!=null)
		{
			String userCode = (String)user.getUserCode();
			IGroupMemberDAO memberdao = sqlSession.getMapper(IGroupMemberDAO.class);
			String position = memberdao.checkMemberGroup(userCode, groupApplyCode);
			
			if ("모임장".equals(position))
			{
				IGroupDAO groupdao = sqlSession.getMapper(IGroupDAO.class);
				GroupDTO list = groupdao.groupHomeGroupInfo(userCode, groupApplyCode);
				model.addAttribute("list", list);
				System.out.println(list);
				return "/WEB-INF/view/group_room/manage/ManageList.jsp";
			}
			else
			{
				model.addAttribute("error", "잘못된 접근입니다.");
				model.addAttribute("url", "/mainpage.do");
				return  "redirect:/errorpage.do";
			}
		}
		else
		{
			model.addAttribute("error", "잘못된 접근입니다.");
			model.addAttribute("url", "/mainpage.do");
			return  "redirect:/errorpage.do";
		}
	}
	
    @RequestMapping(value="/applicant.do", method = RequestMethod.GET)
    public String groupJoinList(@RequestParam("groupApplyCode") String groupApplyCode, Model model, HttpServletRequest request)
    {
    	HttpSession session = request.getSession();
    	UserDTO user = (UserDTO)session.getAttribute("user");
    	
    	// 로그인 페이지
    	 if(user == null) {
             return "redirect:/loginpage.do";
         }
        IGroupJoinDAO dao = sqlSession.getMapper(IGroupJoinDAO.class);
        IGroupDAO groupDao = sqlSession.getMapper(IGroupDAO.class);

        // 해당 모임의 가입 신청자 목록 조회
        List<GroupJoinDTO> applicantList = dao.selectJoinRequestByGroup(groupApplyCode);
        
        int waitingCount = dao.countWaitingGroupMember(groupApplyCode);
        
        model.addAttribute("waitingCount", waitingCount);

        // 결과를 JSP로 전달
        model.addAttribute("applicantList", applicantList);

        // JSP 경로 리턴
        return "/WEB-INF/view/group_room/manage/Applicant.jsp";
    }
    
    @RequestMapping(value = "/membermanage.do", method = RequestMethod.GET)
    public String groupManageMemberList(
        @RequestParam("groupApplyCode") String groupApplyCode, 
        HttpSession session, 
        Model model) 
    {
   
        System.out.println("====================================");
        System.out.println("🚀 membermanage.do 컨트롤러 시작!");
        System.out.println("====================================");
        System.out.println("📌 groupApplyCode: " + groupApplyCode);
        
        // 1. 로그인 체크
        UserDTO user = (UserDTO) session.getAttribute("user");
        System.out.println("📌 user 객체: " + user);
        
        if (user == null) {
            System.out.println("❌ 로그인 안 됨 - loginpage.do로 리다이렉트");
            return "redirect:loginpage.do";
        }
        
        System.out.println("✅ 로그인 됨 - UserCode: " + user.getUserCode());
        
        IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
        IGroupMemberManageDAO quitDao = sqlSession.getMapper(IGroupMemberManageDAO.class);
        System.out.println("✅ DAO 매퍼 생성 완료");
        
        try {
            System.out.println("\n--- Try 블록 진입 ---");
            
            // 2. 모임 상세 정보 조회
            System.out.println("▶ groupDetail 조회 시작...");
            GroupDTO groupDetail = dao.groupDetail(groupApplyCode);
            System.out.println("▶ groupDetail 조회 완료: " + groupDetail);
            
            if (groupDetail == null) {
                System.out.println("❌ groupDetail이 null입니다!");
            } else {
                System.out.println("✅ groupDetail 존재");
                System.out.println("   - 모임명: " + groupDetail.getGroupTitle());
            }
            
            // 4. 모임 멤버 목록 조회
            System.out.println("\n▶ memberList 조회 시작...");
            List<GroupDTO> memberList = dao.groupManageMemberList(groupApplyCode);
            List<GroupMemberManageDTO> quitReasonList = quitDao.quitReason("2");
            model.addAttribute("quitReasonList", quitReasonList);
            System.out.println("▶ memberList 조회 완료");
            
            System.out.println("\n========== 멤버 리스트 결과 ==========");
            System.out.println("memberList: " + memberList);
            
            if (memberList == null) {
                System.out.println("❌ memberList가 null!");
            } else if (memberList.isEmpty()) {
                System.out.println("⚠️ memberList가 비어있음 (size: 0)");
            } else {
                System.out.println("✅ memberList 크기: " + memberList.size());
                for (GroupDTO m : memberList) {
                    System.out.println("👤 " + m.getNickName() + " / " + m.getPosition());
                }
            }
            System.out.println("====================================\n");
            
            // 5. 모델에 담기
            System.out.println("▶ 모델에 데이터 추가 중...");
            model.addAttribute("groupDetail", groupDetail);
            model.addAttribute("groupTitle", groupDetail.getGroupTitle()); 
            model.addAttribute("memberList", memberList);
            model.addAttribute("groupApplyCode", groupApplyCode);
            System.out.println("✅ 모델 데이터 추가 완료");
            
        } catch (Exception e) {
            System.out.println("\n");
            System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            System.out.println("❌❌❌ 예외 발생! ❌❌❌");
            System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            System.out.println("예외 타입: " + e.getClass().getName());
            System.out.println("예외 메시지: " + e.getMessage());
            System.out.println("\n--- 스택 트레이스 ---");
            e.printStackTrace();
            System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
            
            model.addAttribute("errorMsg", "멤버 목록을 불러오는 중 오류가 발생했습니다.");
            return "redirect:home.do?groupApplyCode=" + groupApplyCode;
        }
        
        // 6. View 반환
        String viewPath = "/WEB-INF/view/group_room/manage/MemberManage.jsp";
        System.out.println("\n▶ JSP로 이동: " + viewPath);
        System.out.println("====================================");
        System.out.println("🏁 membermanage.do 컨트롤러 종료");
        System.out.println("====================================\n");
        
        return viewPath;
    }
    
	
	@RequestMapping(value="/groupedit.do", method=RequestMethod.GET)
	public String groupEdit(
		@RequestParam("groupApplyCode") String groupApplyCode,
		HttpSession session, 
		Model model)
	{
		// 🚨 1. 로그인 체크
		UserDTO user = (UserDTO)session.getAttribute("user");
		if(user == null) {
			return "redirect:loginpage.do";
		}
		
		IGroupDAO dao = sqlSession.getMapper(IGroupDAO.class);
		
		try {
			// 2. 그룹 상세 정보 조회 (기존 데이터 로드)
			GroupDTO groupDetail = dao.groupDetail(groupApplyCode);
			
			
		
			
			// 4. 질문 및 규칙 정보 로드
			GroupDTO questionRule = dao.groupQuestionRule(groupApplyCode);
			
			// 5. Model에 데이터 추가
			model.addAttribute("groupDetail", groupDetail);
		
			
			// 6. View 반환
			return "/WEB-INF/view/group_room/manage/EditGroup.jsp";
			
		} catch (Exception e) {
			System.out.println("❌ groupEdit() 예외 발생: " + e.getMessage());
			e.printStackTrace();
			model.addAttribute("msg", "모임 정보를 불러오는 중 오류가 발생했습니다.");
			return "redirect:mainpage.do";
		}
	}

	
	// 전체 리스트 가져오기
	@RequestMapping(value="/postmanage.do", method=RequestMethod.GET)
	public String postList(String groupApplyCode, HttpServletRequest request, Model model, String pageNum)
	{
		// sqlSession 가져오기
		IGroupPostDAO dao = sqlSession.getMapper(IGroupPostDAO.class);
		 

		// 페이지 번호 초기화
		int currentPage = 1;	// 기본값
		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		// 전체 데이터 개수 구하기
		int dataCount = dao.listCount(groupApplyCode);
		int numPerPage = 10;	// 한 페이지에 표시할 데이터 개수
		
		Paging paging = new Paging();
		int totalPage = paging.getPageCount(numPerPage, dataCount);
		
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
			
		// url 생성
		String cp = request.getContextPath();
		String listUrl = cp + "/postmanage.do?groupApplyCode=" + groupApplyCode;
		String pageIndexList = paging.pageIndexList(currentPage, totalPage, listUrl);
		
		// model에 데이터 담기
		model.addAttribute("list", dao.list(groupApplyCode, start, end));
		model.addAttribute("noticeList", dao.noticeList(groupApplyCode));
		model.addAttribute("pageIndexList", pageIndexList);
		model.addAttribute("start", start);
		
		// 주소 구성
		String articleUrl = "/WEB-INF/view/group_room/manage/PostManage.jsp";
		articleUrl += "?pageNum=" + currentPage;
		
		return articleUrl;
	}
    
	@RequestMapping(value = "/groupeditcomplete.do", method=RequestMethod.POST)
	public String updateGroupInfo(GroupDTO groupDTO)
	{
		String url = "redirect:home.do?groupApplyCode=" + groupDTO.getGroupApplyCode();
		
		IGroupDAO groupDAO = sqlSession.getMapper(IGroupDAO.class);
		
		groupDAO.updateGroupInfo(groupDTO);
		
		return url;
	}
    
    
}
