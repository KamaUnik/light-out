extends Node2D
@onready var light_children = $Lights.get_children()

var is_activated = false

func activate() -> void:
	if is_activated:
		return
	is_activated = true
	for l in light_children:
		l.activate()
	
