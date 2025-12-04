extends CharacterBody2D


const SPEED = 300.0
@export var hp:float = 100.0
@onready var ray_r = $Rayright
@onready var ray_l = $RayLeft
var direction = 1

func _to_string():
	return "Enemy"


func _physics_process(delta: float) -> void:
	if ray_r.is_colliding():
		direction = -1
	if ray_l.is_colliding():
		direction = 1
	position.x += direction*SPEED*delta

func hurt(delta:float):
	hp-=delta*70
	if hp<0.0:
		queue_free()
