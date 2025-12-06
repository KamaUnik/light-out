extends Node2D

@onready var interactable : Area2D = $Interactable
@onready var sprite : Sprite2D= $Sprite2D
@export var state : bool = false

func _ready() -> void:
	interactable.interact = _on_interact
	if(state):
		sprite.frame=1

func _on_interact():
	sprite.frame = 1 - sprite.frame
	state = not state
	get_parent().activate()
