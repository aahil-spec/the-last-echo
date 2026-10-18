extends StaticBody3D


@export_file("*.tscn") var target_floor_path:String="res://scenes/floor_5.tscn"

func interact():
	if target_floor_path!="":
		get_tree().change_scene_to_file(target_floor_path)
