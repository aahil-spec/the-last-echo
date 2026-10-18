extends Node3D

@export var plates_required:int=2
var active_plates:int=0
var baseline_position:Vector3
var is_solved:bool=false
var door_tween:Tween

func _ready():
	baseline_position=position
	
func _on_pressure_plate_activated():
	active_plates+=1
	check_door()
	
func _on_pressure_plate_deactivated():
	active_plates=max(0,active_plates-1)
	
func _on_pressure_plate_2_activated():
	active_plates+=1
	check_door()
	
func _on_pressure_2_deactivated():
	active_plates=max(0,active_plates-1)
	
func check_door():
	if is_solved:
		return
	if active_plates>=plates_required:
		is_solved=true
	if door_tween:
		door_tween.kill()
	door_tween=create_tween()
	door_tween.tween_property(self,"position",baseline_position+Vector3(0,3.0,0),1.0)
	
func restore_baseline():
	if is_solved:
		return
	active_plates=0
	position=baseline_position
