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
					_this.siblings('.voting-info-numbers').html("<span class=\"upvote-number\">Upvotes: " + data.upvotes + " </span><span class=\"downvote-number\">Downvotes: " + data.downvotes + "</span>");
				}
			});
		
		if (user_id != "") {
			$(this).siblings('.icon-arrow-down').removeClass('color-red');
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
					_this.siblings('.voting-info-numbers').html("<span class=\"upvote-number\">Upvotes: " + data.upvotes + " </span><span class=\"downvote-number\">Downvotes: " + data.downvotes + "</span>");
				}
			});
		
		if (user_id != "") {
			$(this).siblings('.icon-arrow-up').removeClass('color-green');
			$(this).toggleClass('color-red');
		}
	});
})