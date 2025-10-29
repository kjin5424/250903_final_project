/**

ajax = createAjax();
ajax.open(method, url, true);
	- method : GET, POST
	- url : AJAX 요청 페이지
	- true : 비동기(false : 동기)
ajax.onreadystatechange = function()
{
	if (ajax.readyState==4 && ajax.status==200)
	{
		// 업무 처리
	}
}
ajax.send("");

 */

var ajax;

function createAjax()
{
	if (window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		return null;
	}
}