extends CanvasLayer


@export var echo_manager:Node
@export var loop_duration:float=30.0

@onready var label:Label=$LoopTimerUI
@onready var fade_screen:ColorRect=$FadeScreen
var time_left:float
func _ready():
	time_left=loop_duration
func _process(delta):
	time_left-=delta
	label.text=str(ceil(time_left))
	if time_left<=0.0:
		force_timeout()
func force_timeout():
	set_process(false)
	var tween=create_tween()
	tween.tween_property(fade_screen,"color:a",1.0,0.5)
	await tween.finished
	time_left=loop_duration
	if echo_manager:
		echo_manager.timeout_reset()
	tween=create_tween()
	tween.tween_property(fade_screen,"color:a",0.0,0.5)
	set_process(true)
func reset_clock():
	time_left=loop_duration
