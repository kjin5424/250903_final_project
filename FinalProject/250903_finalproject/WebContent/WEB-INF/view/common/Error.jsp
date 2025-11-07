<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath(); 
    String error = request.getParameter("error");
    String url = request.getParameter("url");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
    <% 
    	if (error != null && !error.isEmpty()) 
    	{ 
    %>
	        window.onload = function() 
	        {
	            if (confirm("<%=error%>"))
				{
		            window.location.href = "<%=cp%>/getback.do?url=<%=url != null ? url : ""%>";
				}
	        }
    <% 
    	}
    %>
</script>
</head>
<body>

</body>
</html>