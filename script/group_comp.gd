extends Node2D

@onready var source_children = $Source.get_children()
@onready var machine_children = $Machine.get_children()
var state = false

func get_State(N: Node2D):
	return N.get_State()

#func current_State():
	#if source_children.any(get_State):
		#state = true
	#else:
		#state = false

func update_machine():
	for m in machine_children:
		m.toggle_State()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func check_State():
	if source_children.any(get_State) !=state:
		update_machine()
		state = source_children.any(get_State)

func _process(_delta: float) -> void:
	check_State()
