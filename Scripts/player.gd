extends CharacterBody3D


@export var walk_speed = 5.0
@export var run_speed = 10.0
@export var dash_speed = 25.0
@export var jump_velocity = 4.5
@export var dash_duration = 0.2
@export var mouse_sensitivity = 0.002

@onready var camera = $Camera3D
@onready var interaction_prompt=$PlayerUI/InteractionPrompt
@onready var interaction_ray=$Camera3D/InteractionRay
@onready var loop_recorder=$LoopRecorder

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var dash_timer = 0.0
var is_dashing = false

func _ready():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
		if not is_on_floor():
				velocity.y -= gravity * delta
		if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = jump_velocity
		if Input.is_action_just_pressed("dash") and not is_dashing:
				is_dashing = true
				dash_timer = dash_duration
		var current_speed = walk_speed
		if is_dashing:
				dash_timer -= delta
				current_speed = dash_speed
				if dash_timer <= 0:
						is_dashing = false
		elif Input.is_action_pressed("run"):
				current_speed = run_speed
		var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if direction:
				velocity.x = direction.x * current_speed
				velocity.z = direction.z * current_speed
		else:
				velocity.x = move_toward(velocity.x, 0, current_speed)
				velocity.z = move_toward(velocity.z, 0, current_speed)
		move_and_slide()
		if interaction_prompt:
			interaction_prompt.visible=false
			if interaction_ray.is_colliding():
				var target=interaction_ray.get_collider()
				if target.has_method("interact") or target.get_parent().has_method("interact"):
					interaction_prompt.visible=true
func _unhandled_input(event):
		if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				rotate_y(-event.relative.x * mouse_sensitivity)
				camera.rotate_x(-event.relative.y * mouse_sensitivity)
				camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
		if event.is_action_pressed("ui_cancel"):
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if event is InputEventMouseButton:
			if event.button_index==MOUSE_BUTTON_RIGHT and event.pressed:
				Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
		if event is InputEventKey and event.pressed and not event.echo and event.keycode==KEY_E:
			interaction_ray.force_raycast_update()
			if interaction_ray.is_colliding():
				var target=interaction_ray.get_collider()
				var final_target=null
				if target.has_method("interact"):
					final_target=target
				elif target.get_parent().has_method("interact"):
					final_target=target.get_parent()
				if final_target:
					final_target.interact()
					if loop_recorder:
						loop_recorder.record_interaction(target)
		
