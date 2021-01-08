$(document).ready(function() {
	var showChar = 20;
	var ellipsestext = "...";
	var moretext = "reply";
	var lesstext = "less";
	$('.more').each(function() {
		var content = $(this).html();

		if(content.length > showChar) {

			var c = content.substr(0, showChar);
			var h = content.substr(showChar-1, content.length - showChar);

			var html = c + '<span class="replyellipses">' + ellipsestext+ '&nbsp;</span><span class="replycontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="replylink">' + moretext + '</a></span>';

			$(this).html(html);
		}

	});

	$(".replylink").click(function(){
		if($(this).hasClass("less")) {
			$(this).removeClass("less");
			$(this).html(moretext);
		} else {
			$(this).addClass("less");
			$(this).html(lesstext);
		}
		$(this).parent().prev().toggle();
		$(this).prev().toggle();
		return false;
	});
});
