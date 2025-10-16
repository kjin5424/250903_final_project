<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/css/undermenubar.css">

<div class="under-menu-bar">
    <nav class="footer-nav">
        <!-- 공지사항 -->
        <a href="<%=cp%>/notice/Notice.jsp" class="footer-tab">
            <span class="footer-tab-icon">📢</span>
            <span>공지사항</span>
        </a>
        
        <!-- 구분선 (선택사항) -->
        <div class="footer-divider"></div>
        
        <!-- 문의하기 -->
        <a href="<%=cp%>/inquiry/Inquiry.jsp" class="footer-tab">
            <span class="footer-tab-icon">💬</span>
            <span>문의하기</span>
        </a>
        
        <!-- 구분선 (선택사항) -->
        <div class="footer-divider"></div>
        
        <!-- 이용약관 (추가 예시) -->
        <a href="<%=cp%>/terms/Terms.jsp" class="footer-tab">
            <span class="footer-tab-icon">📋</span>
            <span>이용약관</span>
        </a>
        
        <!-- 구분선 (선택사항) -->
        <div class="footer-divider"></div>
        
        <!-- 개인정보처리방침 (추가 예시) -->
        <a href="<%=cp%>/privacy/Privacy.jsp" class="footer-tab">
            <span class="footer-tab-icon">🔒</span>
            <span>개인정보처리방침</span>
        </a>
    </nav>
    
    <!-- 추가 정보 (선택사항) -->
    <!-- 
    <div class="footer-info">
        © 2025 공모자들. All rights reserved.
    </div>
    -->
</div>