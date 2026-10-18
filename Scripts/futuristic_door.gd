extends StaticBody3D


@onready var animation_player=$Sketchfab_Scene3/AnimationPlayer
@export var open_animation_name:String="DoorAnimationALL"
var is_open:bool=false

func _ready():
	add_to_group("resettable")
	
func open_door():
	if not is_open:
		is_open=true
		if animation_player:
			animation_player.play(open_animation_name)
			
func restore_baseline():
	is_open=false
	if animation_player:
		animation_player.seek(0,true)
		animation_player.stop()
		
