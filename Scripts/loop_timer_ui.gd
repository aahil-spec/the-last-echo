extends CanvasLayer


@export var echo_manager:Node
var time_left:float=60.0

@onready var label:Label=$LoopTimerUI

func _process(delta):
	time_left-=delta
	label.text=str(ceil(time_left))
	if time_left<=0.0:
		force_timeout()
		
func force_timeout():
	time_left=60.0
	if echo_manager:
		echo_manager.spawn_echo()
		
func reset_clock():
	time_left=60.0
