extends AnimatableBody3D


var path_data:Array[Transform3D]=[]
var current_index:int=0
var playback_timer:float=0.0
const RECORD_INTERVAL:float=0.05

func _physics_process(delta):
	if path_data.is_empty() or current_index>=path_data.size():
		return
	playback_timer+=delta
	if playback_timer>=RECORD_INTERVAL:
		global_transform=path_data[current_index]
		current_index+=1
		playback_timer=0.0
