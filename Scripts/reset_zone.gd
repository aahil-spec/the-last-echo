extends Area3D


func is_player(body):
	return "player" in body.name.to_lower()
	
func _on_body_entered(body):
	if is_player(body):
		var player_ui=body.get_node_or_null("PlayerUI")
		if player_ui and player_ui.has_method("force_timeout"):
			player_ui.force_timeout()
