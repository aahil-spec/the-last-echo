extends AnimatableBody3D


var path_data:Array[Transform3D]=[]
var interaction_data:Array[Dictionary]=[]
var current_index:int=0
var playback_timer:float=0.0
var total_time:float=0.0
const RECORD_INTERVAL:float=0.05

func _physics_process(delta):
	total_time+=delta
	while interaction_data.size()>0 and total_time>=interaction_data[0]["time"]:
		var event=interaction_data.pop_front()
		var target=get_node_or_null(event["target_path"])
		if target and target.has_method("interact"):
			print("Echo triggered interaction on: ", target.name)
			target.interact()
	if path_data.is_empty() or current_index>=path_data.size():
		return
	playback_timer+=delta
	if playback_timer>=RECORD_INTERVAL:
		global_transform=path_data[current_index]
		current_index+=1
		playback_timer=0.0
