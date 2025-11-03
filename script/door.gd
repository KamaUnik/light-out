extends Node2D

@onready var player = $AnimationPlayer
var state = false

func _ready() -> void:
	if( not state):
		close()
	else:
		open()
	

func open():
	player.play("act")
	
func close():
	player.play("deact")

func toggle_State():
	if(state):
		close()
	else:
		open()
	state = not state
