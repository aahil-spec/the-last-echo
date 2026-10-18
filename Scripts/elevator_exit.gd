extends Area3D


@export var next_floor_path:String="res://scenes/floor_2.tscn"

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.name=="player":
		print("Puzzle complete! Loading next floor...")
		get_tree().change_scene_to_file(next_floor_path)
