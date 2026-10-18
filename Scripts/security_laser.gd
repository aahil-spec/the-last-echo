extends Area3D

@export var move_offset:Vector3=Vector3(0,1.5,0)
var start_position:Vector3
var laser_tween:Tween

func is_player_or_echo(body):
	var name_lower=body.name.to_lower()
	return "player" in name_lower or "echo" in name_lower
	
func _ready():
	start_position=position
	add_to_group("resettable")
	body_entered.connect(_on_body_entered)
	var random_speed=randf_range(1.2,2.8)
	var random_delay=randf_range(0.0,1.5)
	await get_tree().create_timer(random_delay).timeout
	start_sweeping(random_speed)
	
func start_sweeping(speed:float):
	if laser_tween:
		laser_tween.kill()
	laser_tween=create_tween().set_loops()
	laser_tween.tween_property(self,"position",start_position+move_offset,speed)
	laser_tween.tween_interval(randf_range(0.1,0.5))
	laser_tween.tween_property(self,"position",start_position,speed)
	laser_tween.tween_interval(randf_range(0.1,0.5))
func _on_body_entered(body):
	if is_player_or_echo(body):
		var reset_manager=get_tree().get_first_node_in_group("reset_manager")
		if reset_manager and reset_manager.has_method("reset_floor"):
			reset_manager.reset_floor()
		else:
			if body.has_node("PlayerUI"):
				body.get_node("PlayerUI").force_timeout()
func restore_baseline():
	if laser_tween:
		laser_tween.kill()
	position=start_position
	start_sweeping(randf_range(1.2,2.8))
func set_laser_active(is_active:bool):
	visible=is_active
	monitoring=is_active
	set_process(is_active)
	if laser_tween:
		if is_active:
			laser_tween.play()
		else :
			laser_tween.pause()
