extends Node3D


signal power_on
signal power_off

@export var button_mesh:MeshInstance3D
var mesh_baseline_position:Vector3
var is_active:bool=false
var buttton_tween:Tween
func _ready():
	add_to_group("interactable")
	add_to_group("resettable")
	if button_mesh:
		mesh_baseline_position=button_mesh.position

func interact():
	is_active=!is_active
	if buttton_tween:
		buttton_tween.kill()
	buttton_tween=create_tween()
	if is_active:
		power_on.emit()
		if button_mesh:
			buttton_tween.tween_property(button_mesh,"position:x",mesh_baseline_position.x-31,0.1)
	else:
		power_off.emit()
		if button_mesh:
			buttton_tween.tween_property(button_mesh,"position:x",mesh_baseline_position.x,0.1)
		
func restore_baseline():
	is_active=false
	power_off.emit()
	if button_mesh:
		button_mesh.position=mesh_baseline_position
