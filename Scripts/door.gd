extends Node3D

var active_plates:int=0
var baseline_position:Vector3
@export var plates_required:int=2


func _ready():
	baseline_position=position
	
func _on_pressure_plate_activated():
	active_plates+=1
	if active_plates>=plates_required:
		open_door()
		
func _on_pressure_plate_deactivated():
	active_plates=max(0,active_plates-1)
	if active_plates<plates_required:
		close_door()
		
func open_door():
	var tween=create_tween()
	tween.tween_property(self,"position",baseline_position+Vector3(0,3.0,0),1.0)
	
func close_door():
	var tween=create_tween()
	tween.tween_property(self,"position",baseline_position,1.0)
	


func _on_pressure_plate_2_activated() -> void:
	pass # Replace with function body.


func _on_pressure_plate_2_deactivated() -> void:
	pass # Replace with function body.
