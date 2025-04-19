extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		self.queue_free()
		var game = get_tree().get_first_node_in_group("game")
		game.hasKey = true
