extends Node3D


@export var plate_1:PressurePlate
@export var plate_2:PressurePlate
@export var target_door:Node3D

var plate_1_active:bool=false
var plate_2_actve:bool=false

func _ready():
	if plate_1:
		plate_1.activated.connect(_on_plate_1_activated)
		plate_1.deactivated.connect(_on_plate_1_deactivated)
	if plate_2:
		plate_2.activated.connect(_on_plate_2_activated)
		plate_2.deactivated.connect(_on_plate_2_deactivated)
		
func _on_plate_1_activated():
	plate_1_active=true
	evaluate_puzzle()
	
func _on_plate_1_deactivated():
	plate_1_active=false
	evaluate_puzzle()
	
func _on_plate_2_activated():
	plate_2_actve=true
	evaluate_puzzle()
	
func _on_plate_2_deactivated():
	plate_2_actve=false
	evaluate_puzzle()
	
func evaluate_puzzle():
	if plate_1_active and plate_2_actve:
		
		target_door.open_door()
	else:
		target_door.close_door()
