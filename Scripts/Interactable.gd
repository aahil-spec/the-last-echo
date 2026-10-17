extends StaticBody3D
class_name Interactable

@export var prompt_text:String="Interact"

func interact():
	print("Interacted with: ", name)
