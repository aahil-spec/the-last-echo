extends AnimatableBody3D


var path_data:Array[Transform3D]=[]
var interaction_data:Array[Dictionary]=[]
var current_index:int=0
var playback_timer:float=0.0
var total_time:float=0.0
const RECORD_INTERVAL:float=0.05
var smoothed_speed:float=0.0
@onready var animation_player=$Visuals/model/AnimationPlayer
var previous_position=Vector3.ZERO

func _physics_process(delta):
	total_time+=delta
	while interaction_data.size()>0 and total_time>=interaction_data[0]["time"]:
		var event=interaction_data.pop_front()
		var target=get_node_or_null(event["target_path"])
		if target and target.has_method("interact"):
			print("Echo triggered interaction on: ", target.name)
			if animation_player:
				animation_player.play("ButtonPushing")
			target.interact()
	if path_data.is_empty() or current_index>=path_data.size():
		return
	playback_timer+=delta
	var target_transform=path_data[current_index]
	global_transform=global_transform.interpolate_with(target_transform,20.0*delta)
	
	if playback_timer>=RECORD_INTERVAL:
		current_index+=1
		playback_timer=0.0
	if animation_player and animation_player.current_animation!="ButtonPushing":
		var distance_moved=global_position.distance_to(previous_position)
		var raw_peed=distance_moved/delta
		smoothed_speed=lerp(smoothed_speed,raw_peed,2.0*delta)
		if smoothed_speed>7.5:
			animation_player.play("Running")
		elif smoothed_speed>0.5:
			animation_player.play("Walking")
		else:
			animation_player.play("Idle")
	previous_position=global_position
	
