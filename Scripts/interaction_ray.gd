extends RayCast3D

@onready var loop_recorder=$"../../LoopRecorder"
func _unhandled_input(event: InputEvent):
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_E:
		force_raycast_update()
		if is_colliding():
			var target=get_collider()
			print("Raycast hit: ", target.name)
			if target is Interactable:
				target.interact()
				if loop_recorder:
					loop_recorder.record_interaction(target)
