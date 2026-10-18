extends Node3D


var baseline_position:Vector3
var door_tween:Tween

func _ready():
	baseline_position=position
	add_to_group("resettable")
	
func _on_pressure_plate_activated():
	if door_tween:
		door_tween.kill()
	door_tween=create_tween()
	door_tween.tween_property(self,"position",baseline_position+Vector3(0,3.0,0),0.5)
	
func _on_pressure_plate_deactivated():
	if door_tween:
		door_tween.kill()
	door_tween=create_tween()
	door_tween.tween_property(self,"position",baseline_position,0.5)
	
func restore_baseline():
	if door_tween:
		door_tween.kill()
	position=baseline_position
