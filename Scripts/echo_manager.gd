extends Node

@export var player_recorder:Node
@export var echo_scene:PackedScene
@export var loop_timer:Node
@export var reset_manager:Node
func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode==KEY_R:
		spawn_echo()
		
func spawn_echo():
	var echo=echo_scene.instantiate()
	add_child(echo)
	echo.path_data=player_recorder.get_recorded_data().duplicate()
	player_recorder.clear_data()
	reset_manager.trigger_room_reset()
	if loop_timer:
		loop_timer.reset_clock()
