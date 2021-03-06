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
					_this.siblings('.voting-info-numbers').html("\( <span class=\"color-green\">" + data.upvotes + " </span>| <span class=\"color-red\">" + data.downvotes + "</span> \)");
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
					_this.siblings('.voting-info-numbers').html("\( <span class=\"color-green\">" + data.upvotes + " </span>| <span class=\"color-red\">" + data.downvotes + "</span> \)");
				}
			});
		
		if (user_id != "") {
			$(this).siblings('.icon-arrow-up').removeClass('color-green');
			$(this).siblings('.votes-cumulative').find('div').removeClass('color-green').toggleClass('color-red');
			$(this).toggleClass('color-red');
		}
	});
})

$(document).on("click", ".reply-button", function () {
	comment_token = $(this).attr('comment_token');
	$('#replyto_' + comment_token).show();
})

$(document).on("click", ".cancel-btn", function () {
	comment_token = $(this).attr('comment_token');
	$('#replyto_' + comment_token).hide();
})

$(document).on("click", ".icon-caret-down", function () {
	comment_token = $(this).attr('comment_token');
	$(".comment_" + comment_token + " > .comment.noncollapsed").toggle();
	$(".comment_" + comment_token + " > .comment.collapsed").toggle();
})

$(document).on("click", ".icon-caret-up", function () {
	comment_token = $(this).attr('comment_token');
	$(".comment_" + comment_token + " > .comment.noncollapsed").toggle();
	$(".comment_" + comment_token + " > .comment.collapsed").toggle();
})

$(document).on("click", ".upvote-comment", function(event) {
	user_id = $(this).attr('user_id');
	related_game_id = $(this).attr('related_game_id');
	comment_token = $(this).attr('comment_token');
	_this = $(this);
	_votes = $('.comment_' + comment_token).find('.comments-vote-numbers_' + comment_token);
	
	$.post('/compare/' + related_game_id + '/comments/upvote_comment', {user_id: user_id, comment_token: comment_token},
		function(data) {
			// update number
			if (user_id != "") {
				_this.siblings('.comment-votes-cumulative').html(data.upvotes - data.downvotes);
				_votes.html("\( <span class=\"color-green\">" + data.upvotes + " </span>| <span class=\"color-red\">" + data.downvotes + "</span> \)");
			}
		});
	
	if (user_id != "") {
		$(this).siblings('.icon-arrow-down').removeClass('color-red');
		$(this).siblings('.comment-votes-cumulative').removeClass('color-red').toggleClass('color-green');
		$(this).toggleClass('color-green');
	}
});

$(document).on("click", ".downvote-comment", function(event) {
	user_id = $(this).attr('user_id');
	related_game_id = $(this).attr('related_game_id');
	comment_token = $(this).attr('comment_token');
	_this = $(this);
	_votes = $('.comment_' + comment_token).find('.comments-vote-numbers_' + comment_token);
	
	$.post('/compare/' + related_game_id + '/comments/downvote_comment', {user_id: user_id, comment_token: comment_token},
		function(data) {
			// update number
			if (user_id != "") {
				_this.siblings('.comment-votes-cumulative').html(data.upvotes - data.downvotes);
				_votes.html("\( <span class=\"color-green\">" + data.upvotes + " </span>| <span class=\"color-red\">" + data.downvotes + "</span> \)");
			}
		});
	
	if (user_id != "") {
		$(this).siblings('.icon-arrow-up').removeClass('color-green');
		$(this).siblings('.comment-votes-cumulative').removeClass('color-green').toggleClass('color-red');
		$(this).toggleClass('color-red');
	}
});