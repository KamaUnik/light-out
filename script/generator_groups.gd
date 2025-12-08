extends Node2D
signal objective_completed
@onready var group_size= get_children().size()
var current_activate = 0
@onready var obj = $"../Objremaining/Label"
# Called when the node enters the scene tree for the first time.
func _ready():
	obj.text = "Remaining: \n0 / "+ str(group_size)
	pass
func activate():
	current_activate+=1
	obj.text = "Remaining: \n"+str(current_activate)+" / "+ str(group_size)
	if current_activate == group_size:
		objective_completed.emit()
