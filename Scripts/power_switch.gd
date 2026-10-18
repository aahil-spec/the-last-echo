extends Node3D


signal power_on
signal power_off

var is_active:bool=false
func _ready():
	add_to_group("interactable")

func interact():
	is_active=!is_active
	if is_active:
		power_on.emit()
	else:
		power_off.emit()
		
func restore_baseline():
	is_active=false
	power_off.emit()
