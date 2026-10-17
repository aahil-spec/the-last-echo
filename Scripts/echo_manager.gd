extends Node

@export var player_recorder:Node
@export var echo_scene:PackedScene
@export var loop_timer:Node
@export var reset_manager:Node

var active_echo:Node=null

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode==KEY_R:
		spawn_echo()
		
func spawn_echo():
	if active_echo!=null:
		active_echo.queue_free()
	active_echo=echo_scene.instantiate()
	add_child(active_echo)
	active_echo.path_data=player_recorder.get_recorded_data().duplicate()
	active_echo.interaction_data = player_recorder.get_recorded_interactions().duplicate(true)
	player_recorder.clear_data()
	reset_manager.trigger_room_reset()
	if loop_timer:
		loop_timer.reset_clock()
