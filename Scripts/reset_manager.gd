extends Node


@export var player:CharacterBody3D
var player_start_transform:Transform3D

func _ready():
	if player:
		player_start_transform=player.global_transform
		
func trigger_room_reset():
	var objects=get_tree().get_nodes_in_group("resettable")
	for obj in objects:
		if obj.has_method("restore_baseline"):
			obj.restore_baseline()
	if player:
		player.global_transform=player_start_transform
