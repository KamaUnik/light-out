extends Node2D
signal objective_completed
@onready var group_size= get_children().size()
var current_activate = 0
# Called when the node enters the scene tree for the first time.
func activate():
	current_activate+=1
	if current_activate == group_size:
		objective_completed.emit()
