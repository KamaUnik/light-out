extends Node2D

@onready var source_children = $Source.get_children()
@onready var machine_children = $Machine.get_children()
var state = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func get_State(N: Node2D):
	return N.get_State()

func current_State():
	if source_children.any(get_State):
		state = true
	else:
		state = false

func update_State():
	for m in machine_children:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	current_State()
