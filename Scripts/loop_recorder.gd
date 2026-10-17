extends Node3D


var recorded_path:Array[Transform3D]=[]
var record_timer:float=0.0
const RECORD_INTERVAL:float=0.05

@onready var player=get_parent() as Node3D

func _physics_process(delta):
	record_timer+=delta
	if record_timer>=RECORD_INTERVAL:
		recorded_path.append(player.global_transform)
		record_timer=0.0
		
func get_recorded_data() ->Array[Transform3D]:
	return recorded_path
	
func clear_data():
	recorded_path.clear()
	record_timer=0.0
