extends Node3D


var baseline_posirion:Vector3
var is_open:bool=false
var door_tween:Tween

func _ready():
	baseline_posirion=position
	add_to_group("resettable")
func _on_power_switch_power_on():
	if not is_open:
		is_open=true
		if door_tween:
			door_tween.kill()
		door_tween=create_tween()
		door_tween.tween_property(self,"position",baseline_posirion+Vector3(0,3.0,0),1.0)
		
func _on_power_switch_power_off():
	if is_open:
		is_open=false
		if door_tween:
			door_tween.kill()
		door_tween=create_tween()
		door_tween.tween_property(self,"position",baseline_posirion,1.0)
		
func restore_baseline():
	is_open=false
	position=baseline_posirion
