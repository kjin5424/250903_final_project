$(function() {
	
	$("#notice td").click(function() {
		var groupId = $(this).data("groupid");
		var contentId = $(this).data("contentid");
		var url = cp + "/noticecontent.action?groupId=" + groupId + "&contentId=" + contentId;
		
		location.href = url;
	});
	
	$("#bulletin td").click(function() {
		var groupId = $(this).data("groupid");
		var contentId = $(this).data("contentid");
		var url = cp + "/bulletincontent.action?groupId=" + groupId + "&contentId=" + contentId;
		
		location.href = url;
	});
});