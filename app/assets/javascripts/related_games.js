$(document).ready( function() {
	
	$(".upvote").click(function(event) {
		user_id = $(this).attr('user_id');
		game1_id = $(this).attr('game1_id');
		game2_id = $(this).attr('game2_id');

		$.post('/related_games/upvote', {user_id: user_id, game1_id: game1_id, game2_id: game2_id});
	});
	
	$(".downvote").click(function(event) {
		user_id = $(this).attr('user_id');
		game1_id = $(this).attr('game1_id');
		game2_id = $(this).attr('game2_id');

		$.post('/related_games/downvote', {user_id: user_id, game1_id: game1_id, game2_id: game2_id});
	});
})