extends CanvasLayer


@export var echo_manager:Node

@export var loop_duration:float=30.0

@onready var label:Label=$LoopTimerUI
var time_left:float
func _ready():
	time_left=loop_duration
func _process(delta):
	time_left-=delta
	label.text=str(ceil(time_left))
	if time_left<=0.0:
		force_timeout()
		
func force_timeout():
	time_left=loop_duration
	if echo_manager:
		echo_manager.timeout_reset()
		
func reset_clock():
	time_left=loop_duration
