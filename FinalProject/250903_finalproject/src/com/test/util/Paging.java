package com.test.util;

public class Paging
{
		// ■ 전체 페이지 수를 구하는 메소드
		public int getPageCount(int numPerPage, int dataCount)
		{
			int pageCount = 0;
			
			pageCount = dataCount/numPerPage;
			
			if (dataCount%numPerPage != 0)
				pageCount++;
			
			return pageCount;
		}
		
		
		// ■ 페이징 처리 기능의 메소드
		// currentPage : 현재 표시할 페이지
		// totalPage   : 전체 페이지 수
		// listUrl     : 링크를 설정할 url(요청하게 될 페이지)
		public String pageIndexList(int currentPage, int totalPage, String listUrl)
		{
			// 1 《Prev  11 12 13 14 15 16 17 18 19 20  Next》 42
			// 이걸 만들고 각각 a링크를 걸어주는 메소드
			// 현재 페이지는 a링크 없이 style이 적용된 span이 있다
			// 어느 페이지에 머물고 있느냐에 따라 변동이 많음
			// ┏━┓
			// ┃ 0┃   1  2  3  4  5  6  7  8  9 10
			// ┃10┃  11 12 13 14 15 16 17 18 19 20
			// ┃20┃  21 22 23 24 25 26 27 28 29 30
			// ┃30┃  31 32 33 34 35 36 37 38 39 40
			// ┗━┛          	    :
			//   ┃ 				:
			//   ┗→『currentPageSetup』 check~~~
			
			
			// 실제 페이징을 저장할 StringBuffer 변수
			//      ------ <a href="List.jsp?PageNum=1">1</a> 
			//             <a href="List.jsp?PageNum=13">Prev</a> 
			//             <a href="List.jsp?PageNum=21">21</a> 
			//             <a href="List.jsp?PageNum=22">22</a> 
			//             <span style='color:orange; font-weight:bold;'>23</span> ...
			StringBuffer strList = new StringBuffer();
			
			int numPerBlock = 10;
			//-- 페이징 처리 시 게시물 리스트 하단의 숫자를 10개씩 보여주도록 설정
			
			
			// 페이징 처리의 핵심 기능을 담당할 변수
			int currentPageSetup;
			//-- 현재 페이지 설정
			//   (이 페이지를 기준으로 보여주는 숫자가 달라져야 함)
			
			
			int page;
			int n;
			//-- 이전 / 다음 페이지 블럭과 같은 처리에서 이동하기 위한 변수
			//   (얼마만큼 이동해야 하는지 알아야 하기 때문)
			
			
			// ○ 페이징 처리가 별도로 필요하지 않은 경우
			// -- 데이터가 존재하지 않거나 데이터의 수가 1페이지도 못채우는 경우는
			//    별도로 페이징 처리를 할 필요가 없다.
			if (currentPage==0)
			// 게시글이 아무것도 없는 상태
			// → 페이징 처리가 있어야 할 위치에 아무것도 없음
				return "";
			
			
			// ※ 페이징 요청을 처리하는 과정에서
			//    URL 경로의 패턴에 대한 처리
			
			/*
			  	- 클라이언트 요청의 형태 → List.jsp
			  	  (pageNum=5로 보내고 싶을 시)
			  	  → List.jsp + 『?』 + pageNum=5
			  	  → List.jsp?pageNum=5
			  	
			  	- 클라이언트 요청의 형태 → List.jsp?searchKey=subject&searchValue=test
			  	  (pageNum=5로 보내고 싶을 시)
			  	  → List.jsp?searchKey=subject&searchValue=test + 『&』 + pageNum=5
			  	  → List.jsp?searchKey=subject&searchValue=test?pageNum=5	--(Ⅹ)
			  	  → List.jsp?searchKey=subject&searchValue=test&pageNum=5  --(○)
			  	  				↓
			 */
			
			// 링크를 구성할 URL에 대한 사전 가공처리
			if (listUrl.indexOf("?") != -1)	//-- 링크를 구성할 URL에 『?』가 들어있으면
				listUrl = listUrl + "&";	//   listUrl += "&";
			else							//-- 링크를 구성힐 URL에 『?』가 없으면
				listUrl = listUrl + "?";	//   listUrl += "?";
			//-- 예를 들어 GET방식으로 검색키와 검색값이 존재하면
			//   이미 request 값에 searchKey와 searchValue가 들어있는 상황이므로
			//   『&』를 붙여 속성에 추가해 주어야 한다.
			
			// ★★★★
			// 항상 (표시할 첫 페이지 - 1) → 0 10 20 30 ...
			currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
			//-- 만약 현재 페이지가 5이고(→ currentPage = 5)
			//   리스트 하단에 보여줄 페이지 갯수가 10이면(→numPerBlock = 10)
			//   『currentPage / numPerBlock』
			//   『5 / 10 = 0』 이며, 여기에 『* 10』→『0』
			
			//   하지만 현재 페이지가 11페이지 라면(→ currentPage = 11)
			//   『11 / 10 = 1』이며, 여기에 『* 10』→『10』
			
			
			if (currentPage % numPerBlock == 0)
				currentPageSetup = currentPageSetup - numPerBlock;
			// ┏━┓
			// ┃ 0┃   1  2  3  4  5  6  7  8  9 10
			// ┃10┃  11 12 13 14 15 16 17 18 19 20
			// ┃20┃  21 22 23 24 25 26 27 28 29 30
			// ┃30┃  31 32 33 34 35 36 37 38 39 40
			// ┗━┛          	    :            ====
			
			// currentPage가 20인 경우... 
			// (currentPage/numPerBlock) * numPerBlock = (20 / 10) * 10 = 20
			// 20의 currentPageSetup은 10이어야 하는데 20이 되어버리는 상황
			// 따라서 currentPageSetup = (currentPage / numPerBlock) * numPerBlock;로 인해
			// 20이 되어버린 currentPegeSetup에서 numPerBlock(10)을 빼아함
			
			
			// 1 페이지(맨 처음으로)
			if ((totalPage>numPerBlock) && (currentPageSetup>0))
			// ┏━┓
			// ┃ 0┃   1  2  3  4  5  6  7  8  9 10
			// ┗━┛							 ====
			// currentPageSetup이 0보다 크고 totalPage가 numPerBlock보다 크다
			// → 『1 페이지(맨 처음으로)』를 만들 수 있는 상황
				strList.append(" <a href='" + listUrl + "pageNum=1'>1</a>");
			// 링크 구성 사전 가공 처리로 인해 이 구문을 수행한 strList는
			// <a href="List.jsp"?pageNum=1>1</a> 또는?
			// <a href="List.jsp"?searchKey=subject&searchValue=test&pageNum=1>1</a>
			
			
			// Prev(이전으로)
			n = currentPage - numPerBlock;
			//-- n : 현재 머물고 있는 페이지에서
			//       페이지를 처리하는 갯수만큼 앞으로 보내기 위한 변수
			//-- 예를 들어, 현재 23페이지에 머물고 있다면
			//   Prev를 통해 이동하는 것은 13페이지
			
			if ((totalPage>numPerBlock) && (currentPageSetup>0))
			// ┏━┓
			// ┃ 0┃   1  2  3  4  5  6  7  8  9 10
			// ┗━┛							 ====
			// 위와 동일한 조건
			// 1 페이지(맨 처음으로) 가 있다는 뜻은 Prev(이전으로)도 있다
				strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Prev</a>");
			//-- 『Prev』를 클릭하여 링크로 이동할 경우 n 변수 페이지로 이동하게 되는데
			//   12 에서 『Prev』할 경우 2 페이지가 되고,
			//   22 에서 『Prev』할 경우 12 페이지가 될 수 있도록 처리하는 방식이다.
			
			
			// 각 페이지 바로가기
			page = currentPageSetup + 1;
			// currentPageSetUp은 항상 (표시할 첫 페이지 - 1)
			// 따라서 각 페이지 바로가기에서 시작될 첫 숫자는 currentPageSetup + 1
			//-- 예를 들어 currentPageSetup에서 10을 가져왔다면
			//   바로가기 페이지는 10부터 시작하는 것이 아니라 11부터 시작
			
			
			while ((page<=totalPage)&&(page<=currentPageSetup+numPerBlock))
			{
				// 현재 페이지 구성
				if (page==currentPage)
					strList.append(" <span style='color:orange; font-weight:bold;'>" + page + "</span>");
				// 현재 페이지를 제외한 나머지 바로가기 구성
				else
					strList.append(" <a href='" + listUrl + "pageNum=" + page + "'>" + page + "</a>");
				
				page++;
			}
			
			// Next(다음으로)
			n = currentPage + numPerBlock;
			if ( (totalPage-currentPageSetup) > numPerBlock)
				strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Next</a>");
			
			// 마지막 페이지(맨 마지막으로)
			if ((totalPage>numPerBlock) && (currentPageSetup+numPerBlock)<totalPage)
				strList.append(" <a href='" + listUrl + "pageNum=" + totalPage + "'>" + totalPage + "</a>");
			
			return strList.toString();
		}
		
}
