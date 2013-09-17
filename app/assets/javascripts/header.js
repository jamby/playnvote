$(document).ready( function() {
	$.get("/games", function(data) {
		var map = {};
		$('input.search-typeahead').typeahead({
			source: function(query, process) {
				var objects = [];

				$.each(data.games, function(i, object) {
					map[object.title] = object;
					objects.push(object.title);
				})
				process(objects);
			},
			updater: function(item) {
				$(".q_id").val(map[item].id);
				return item;
			}
		});
	}, "json");

	$("input.search-typeahead").keyup( function() {
		$(".q_id").val('');
	});
});