extends Node2D

@onready var animplay : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animplay.play("RESET")

func activate():
	animplay.play("on")

func deactivate():
	animplay.play("RESET")
