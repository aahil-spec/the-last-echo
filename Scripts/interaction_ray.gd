extends RayCast3D


func _unhandled_input(event: InputEvent):
	if event is InputEventKey and event.pressed and event.keycode==KEY_E:
		if is_colliding():
			var target=get_collider()
			if target is Interactable:
				target.interact()
