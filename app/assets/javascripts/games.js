$(document).ready(function() {
	$.get("#{request.fullpath}", function(data) {
		var map = {};
		$('input.typeahead').typeahead({
			source: function(query, process) {
				var objects = [];
				
				$.each(data.games, function(i, object) {
					map[object.title] = object;
					objects.push(object.title);
				})
				process(objects);
			},
			updater: function(item) {
				$(".search_game_id").val(map[item].id);
				return item;
			}
		});
	}, "json");
	
	$("input.typeahead").keyup( function() {
		$(".search_game_id").val('');
	});
});