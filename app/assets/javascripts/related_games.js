$(document).ready( function() {
	
	$(".upvote").click(function(event) {
		user_id = $(this).attr('user_id');
		game1_id = $(this).attr('game1_id');
		game2_id = $(this).attr('game2_id');
		_this = $(this);
		
		$.post('/compare/upvote', {user_id: user_id, game1_id: game1_id, game2_id: game2_id},
			function(data) {
				// update number
				if (user_id != "") {
					_this.siblings('.votes-cumulative').find('div').html(data.upvotes - data.downvotes);
					_this.siblings('.voting-info-numbers').html("\( <span class=\"color-green upvote-number\">" + data.upvotes + " </span>| <span class=\"color-red downvote-number\">" + data.downvotes + "</span> \)");
				}
			});
		
		if (user_id != "") {
			$(this).siblings('.icon-arrow-down').removeClass('color-red');
			$(this).siblings('.votes-cumulative').find('div').removeClass('color-red').toggleClass('color-green');
			$(this).toggleClass('color-green');
		}
	});
	
	$(".downvote").click(function(event) {
		user_id = $(this).attr('user_id');
		game1_id = $(this).attr('game1_id');
		game2_id = $(this).attr('game2_id');
		_this = $(this);
		
		$.post('/compare/downvote', {user_id: user_id, game1_id: game1_id, game2_id: game2_id},
			function(data) {
				// update number
				if (user_id != "") {
					_this.siblings('.votes-cumulative').find('div').html(data.upvotes - data.downvotes);
					_this.siblings('.voting-info-numbers').html("\( <span class=\"color-green upvote-number\">" + data.upvotes + " </span>| <span class=\"color-red downvote-number\">" + data.downvotes + "</span> \)");
				}
			});
		
		if (user_id != "") {
			$(this).siblings('.icon-arrow-up').removeClass('color-green');
			$(this).siblings('.votes-cumulative').find('div').removeClass('color-green').toggleClass('color-red');
			$(this).toggleClass('color-red');
		}
	});
	
	// $(".reply-button").click(function() {
	// 	comment_id = $(this).attr('comment_id');
	// 	console.log(comment_id);
	// 	$('#replyto_' + comment_id).toggle();
	// });
})

$(document).on("click", ".reply-button", function () {
		comment_id = $(this).attr('comment_id');
		$('#replyto_' + comment_id).toggle();
})