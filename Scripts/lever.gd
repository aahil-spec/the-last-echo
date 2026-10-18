extends StaticBody3D

@onready var anim_player=$"../AnimationPlayer"
@export var hold_duration:float=1.5
var current_hold_time:float=0.0
var lasers_disabled:bool=false
func interact():
	pass
func _process(delta):
	var player=null
	for node in get_tree().get_nodes_in_group("resettable"):
		if node is CharacterBody3D:
			player=node
			break
	var is_holding=false
	if player and global_position.distance_to(player.global_position)<3.0:
		if Input.is_key_pressed(KEY_E):
			is_holding=true
	if is_holding:
		current_hold_time=min(hold_duration,current_hold_time+delta)
		if not lasers_disabled and current_hold_time>0.1:
			lasers_disabled=true
			set_room_lasers(false)
	else:
		current_hold_time=max(0.0,current_hold_time-(delta*2.0))
		if lasers_disabled and current_hold_time<=0.0:
			lasers_disabled=false
			set_room_lasers(true)
	if anim_player and anim_player.has_animation("pull"):
				var anim_len=anim_player.get_animation("pull").length
				anim_player.seek(clamp((current_hold_time / hold_duration) * anim_len, 0, anim_len), true)
		
func set_room_lasers(active:bool):
	for obj in get_tree().get_nodes_in_group("resettable"):
		if obj.has_method("set_laser_active"):
			obj.set_laser_active(active)
func restore_baseline():
	current_hold_time=0.0
	lasers_disabled=false
	set_room_lasers(true)
	if anim_player and anim_player.has_animation("pull"):
		anim_player.seek(0,true)
		anim_player.stop()
