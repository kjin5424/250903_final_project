/**
 * 
 */

$(function()
{
	$(".radio-group input[type='radio']").change(function()
	{
		
		if ($(this).val()=="daily")
		{
			$(".input-week").css("display", "none")
			$(".input-day").css("display", "block");
		}
		
		else if ($(this).val()=="weekly")
		{
			$(".input-day").css("display", "none");
			$(".input-week").css("display", "block");
		}
	});
});