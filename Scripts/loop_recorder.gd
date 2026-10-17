extends Node3D


var recorded_path:Array[Transform3D]=[]
var recorded_interactions:Array[Dictionary]=[]
var record_timer:float=0.0
var total_time:float=0.0
const RECORD_INTERVAL:float=0.05

@onready var player=get_parent() as Node3D

func _physics_process(delta):
	total_time+=delta
	record_timer+=delta
	if record_timer>=RECORD_INTERVAL:
		recorded_path.append(player.global_transform)
		record_timer=0.0
		
func record_interaction(target:Node):
	recorded_interactions.append({
		"time":total_time,
		"target_path":target.get_path()
	})
func get_recorded_data() ->Array[Transform3D]:
	return recorded_path
	
func get_recorded_interactions()->Array[Dictionary]:
	return recorded_interactions
func clear_data():
	recorded_path.clear()
	recorded_interactions.clear()
	record_timer=0.0
	total_time=0.0
	
