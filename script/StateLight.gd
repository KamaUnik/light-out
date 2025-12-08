extends Node2D
@onready var light_children = $Machines.get_children()

var is_activated = false
#Insert light.tscn and gen_door.tscn here
func activate() -> void:
	get_parent().activate()
	if is_activated:
		return
	is_activated = true
	for l in light_children:
		l.activate()
	
