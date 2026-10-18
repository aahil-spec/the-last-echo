extends Node

@export var player_recorder:Node
@export var echo_scene:PackedScene
@export var loop_timer:CanvasLayer
@export var reset_manager:Node

var active_echo:Node=null

var saved_path_data:Array=[]
var saved_interaction_data:Array=[]

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode==KEY_R:
		if player_recorder:
			saved_path_data = player_recorder.get_recorded_data().duplicate(true)
			saved_interaction_data=player_recorder.get_recorded_interactions().duplicate(true)
		execute_loop_reset()
func timeout_reset():
	execute_loop_reset()
	
func execute_loop_reset():
	if active_echo!=null:
		active_echo.queue_free()
	if saved_path_data.size()>0:
		active_echo=echo_scene.instantiate()
		add_child(active_echo)
		active_echo.path_data=saved_path_data.duplicate(true)
		active_echo.interaction_data = saved_interaction_data.duplicate(true)
	if player_recorder:
		player_recorder.clear_data()
	if reset_manager:
		reset_manager.trigger_room_reset()
	if loop_timer and loop_timer.has_method("reset_clock"):
		loop_timer.reset_clock()
