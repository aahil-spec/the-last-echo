extends StaticBody3D


@onready var animation_player=$Sketchfab_Scene3/AnimationPlayer
@onready var door_collision=$CollisionShape3D2
@export var open_animation_name:String="DoorAnimationALL"
var is_open:bool=false

func _ready():
	add_to_group("resettable")
	add_to_group("interactable")
	
func interact():
	if not is_open:
		is_open=true
		if door_collision:
			door_collision.set_deferred("disabled",true)
		if animation_player:
			animation_player.stop()
			animation_player.play(open_animation_name)
			animation_player.seek(0.0,true)
			await get_tree().create_timer(1.0768).timeout
			if is_open and animation_player.is_playing():
				animation_player.pause()
			
func restore_baseline():
	is_open=false
	if door_collision:
		door_collision.set_deferred("disabled",false)
	if animation_player:
		animation_player.stop()
		animation_player.play(open_animation_name)
		animation_player.seek(0.0,true)
		animation_player.stop()
		
