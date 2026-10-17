extends Resettable
class_name Door

@export var open_offset:Vector3=Vector3(0,3,0)

var is_open:bool=false
var baseline_position:Vector3

func _ready():
	baseline_position=global_position
	
func open_door():
	if is_open:return
	is_open=true
	var tween=create_tween()
	tween.tween_property(self,"global_position",baseline_position+open_offset,0.5)
	
func close_door():
	if not is_open:return
	is_open=false
	var tween=create_tween()
	tween.tween_property(self,"global_position",baseline_position,0.5)
	
func restore_baseline():
	is_open=false
	global_position=baseline_position
