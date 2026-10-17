extends Resettable
class_name PressurePlate

signal activated
signal deactivated

var is_pressed:bool=false
var bodies_on_plate:int=0

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	bodies_on_plate+=1
	if not is_pressed:
		is_pressed=true
		activated.emit()
@warning_ignore("unused_parameter")
func _on_body_exited(body):
	bodies_on_plate=max(0,bodies_on_plate-1)
	if bodies_on_plate==0 and is_pressed:
		is_pressed=false
		deactivated.emit()
func restore_baseline():
	bodies_on_plate=0
	is_pressed=false
	deactivated.emit()
