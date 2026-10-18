extends Node3D

var plate_1_active:bool=false
var plate_2_active:bool=false
var baseline_position:Vector3
var is_solved:bool=false
var door_tween:Tween

func _ready():
	baseline_position=position
	
func _on_pressure_plate_activated():
	plate_1_active=true
	check_door()
	
func _on_pressure_plate_deactivated():
	plate_1_active=false
	
func _on_pressure_plate_2_activated():
	plate_2_active=true
	check_door()
	
func _on_pressure_plate_2_deactivated():
	plate_2_active=false
	
func check_door():
	if is_solved:
		return
	if plate_1_active and plate_2_active:
		is_solved=true
		if door_tween:
			door_tween.kill()
		door_tween=create_tween()
		door_tween.tween_property(self,"position",baseline_position+Vector3(0,3.0,0),1.0)
	
func restore_baseline():
	if is_solved:
		return
	plate_1_active=false
	plate_2_active=false
	position=baseline_position
