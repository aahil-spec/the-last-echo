extends Resettable
class_name PressurePlate

signal activated
signal deactivated

var is_pressed:bool=false
var bodies_on_plate:int=0
var mesh_baseline_position:Vector3
@export var plate:MeshInstance3D
func _ready():
	if plate:
		mesh_baseline_position=plate.position

@warning_ignore("unused_parameter")
func _on_sensor_body_entered(body):
	if body.name.to_lower() != "player" and not "echo" in body.name.to_lower():
		return
	bodies_on_plate+=1
	if not is_pressed:
		is_pressed=true
		activated.emit()
		if plate:
			var tween=create_tween()
			tween.tween_property(plate,"position",mesh_baseline_position+Vector3(0,0,-2.5),0.1)
@warning_ignore("unused_parameter")
func _on_sensor_body_exited(body):
	if body.name.to_lower() != "player" and not "echo" in body.name.to_lower():
		return
	bodies_on_plate=max(0,bodies_on_plate-1)
	if bodies_on_plate==0 and is_pressed:
		is_pressed=false
		deactivated.emit()
		if plate:
			
			var tween=create_tween()
			tween.tween_property(plate,"position",mesh_baseline_position,0.2)
func restore_baseline():
	bodies_on_plate=0
	is_pressed=false
	deactivated.emit()
	if plate:
		plate.position=mesh_baseline_position
