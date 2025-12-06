class_name goal 
extends Area2D

@onready var light: PointLight2D = $PointLight2D
@onready var animplay: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	light.enabled=false
	monitoring = false
	monitorable = false

func activate():
	print("Goal Activated")
	animplay.play("activate")
