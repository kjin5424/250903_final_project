<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 게시글 상세보기</title>

<!-- CSS 파일 임포트 -->
<link rel="stylesheet" href="css_new/common_sample.css">
<link rel="stylesheet" href="css_new/topmenubar_sample.css">
<link rel="stylesheet" href="css_new/notice_sample.css">
<link rel="stylesheet" href="css_new/post_sample.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(document).ready(function() {
        // 스크롤 시 헤더 스타일 변경
        $(window).scroll(function() {
            if ($(this).scrollTop() > 50) {
                $('.navbar').addClass('scrolled');
            } else {
                $('.navbar').removeClass('scrolled');
            }
        });
    });

    function editPost() {
        if (confirm('게시글을 수정하시겠습니까?')) {
            window.location.href = '/editpost.do';
        }
    }

    function deletePost() {
        if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
            alert('게시글이 삭제되었습니다.');
            window.location.href = 'postlist.do';
        }
    }

    function submitComment() {
        const textarea = document.getElementById('commentText');
        const content = textarea.value.trim();
        
        if (!content) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }
        
        // 실제로는 서버에 댓글 등록 요청
        alert('댓글이 등록되었습니다.');
        textarea.value = '';
    }

    function deleteComment(commentId) {
        if (confirm('댓글을 삭제하시겠습니까?')) {
            alert('댓글이 삭제되었습니다.');
            // 실제로는 서버에 삭제 요청 후 DOM 업데이트
        }
    }
</script>

</head>
<body>
    <!-- ================================================
         상단 메뉴바
         ================================================ -->
    <!-- 상단바 (그라디언트 영역) -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

    <!-- 메인 컨텐츠 -->
    <div class="notice-detail-container">
        <div class="notice-detail">
            <!-- 게시글 헤더 -->
            <div class="notice-detail-header">
                <div class="post-title-wrapper">
                    <span class="post-category category-notice">${post.boardCategory }</span>
                    <h1 class="notice-detail-title">${post.subject }</h1>
                </div>
                <div class="notice-detail-meta">
                    <div class="notice-detail-meta-item">
                        <div class="author-avatar">${post.savePath }</div>
                        <span>${post.nickName }</span>
                    </div>
                    <div class="notice-detail-meta-item">
                    	   📅${post.createdDate }
                    	 <c:if test="${not empty post.updatedDate }">
                    	 	(수정일 ${post.updatedDate })
                    	 </c:if>
                    </div>
                    <c:if test="${not empty post.commentCount and post.commentCount >= 0 }">
						<div class="notice-detail-meta-item">
                        	💬 ${post.commentCount }
                   		</div>	
                    </c:if>
                </div>
            </div>

            <!-- 게시글 본문 -->
            <div class="notice-detail-content">
                ${post.content }
            </div>

            <!-- 버튼 영역 -->
            <div class="notice-actions">
                <button class="btn-notice-action" onclick="location.href='postlist.do'">📋 목록으로</button>
                <button class="btn-notice-action" onclick="editPost()">✏️ 수정</button>
                <button class="btn-notice-action" onclick="deletePost()">🗑️ 삭제</button>
            </div>

            <!-- 댓글 섹션 -->
            <div class="comments-section">
                <h3 class="comments-title">
              	      💬 댓글 
                <span class="comment-count">${post.commentCount }</span>
                </h3>

                <!-- 댓글 작성 -->
                <div class="comment-write">
                    <textarea id="commentText" class="comment-textarea" 
                              placeholder="댓글을 입력하세요..."></textarea>
                    <div class="comment-submit-area">
                        <button class="btn-submit-comment" onclick="submitComment()">
                         	   💬 댓글 작성
                        </button>
                    </div>
                </div>

                <!-- 댓글 리스트 -->
                <div class="comment-list">
                	<c:forEach var="dto" items="${commentList}">
                		<div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author-info">
                                <div class="author-avatar">${dto.savePath }</div>
                                <div>
                                    <div class="comment-author-name">${dto.nickName }</div>
                                    <div class="comment-date">${dto.createdDate }
	                                    <c:if test="${not empty dto.updatedDate }">
				                    		(수정일 ${dto.updatedDate })
				                    	</c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="comment-actions">
                                <button class="btn-comment-action" onclick="updateComment(${dto.commentCode})">수정</button>
                                <button class="btn-comment-action" onclick="deleteComment(${dto.commentCode})">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">${dto.content }</div>
                    </div>
                	</c:forEach>
                </div>
            </div>
        </div>

        <!-- 이전/다음 네비게이션 -->
        <div class="notice-navigation">
            <div class="notice-nav-item">
                <span class="notice-nav-label">이전글</span>
                <span class="notice-nav-title">이전 게시글 제목이 여기에 표시됩니다</span>
            </div>
            <div class="notice-nav-item">
                <span class="notice-nav-label">다음글</span>
                <span class="notice-nav-title">다음 게시글 제목이 여기에 표시됩니다</span>
            </div>
        </div>
    </div>
</body>
</html>