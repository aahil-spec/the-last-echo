extends AnimatableBody3D


@export var target_offset:Vector3=Vector3(0,0,10.0)
@export var travel_time:float=3.0

var start_position:Vector3
var platform_tween:Tween

func _ready():
	start_position=position
	add_to_group("resettable")
	start_cycle()
	
func start_cycle():
	if platform_tween:
		platform_tween.kill()
	platform_tween=create_tween().set_loops()
	platform_tween.tween_property(self,"position",start_position+target_offset,travel_time)
	platform_tween.tween_interval(0.5)
	platform_tween.tween_property(self,"position",start_position,travel_time)
	platform_tween.tween_interval(0.5)
	
func restore_baseline():
	if platform_tween:
		platform_tween.kill()
	position=start_position
	start_cycle()
