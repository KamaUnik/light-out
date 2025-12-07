extends CharacterBody2D


const SPEED = 600.0
@export var hp:float = 100.0
@onready var ray_r = $Rayright
@onready var ray_bot_r = $Raybottomright
@onready var ray_l = $RayLeft
@onready var ray_bot_l = $Raybottomleft
@onready var animsprite = $AnimatedSprite2D
var direction = 1

func _to_string():
	return "Enemy"


func _physics_process(delta: float) -> void:
	if ray_r.is_colliding() or not ray_bot_r.is_colliding():
		direction = -1
	if ray_l.is_colliding() or not ray_bot_l.is_colliding():
		direction = 1
	animsprite.flip_h = (direction==-1)
	position.x += direction*SPEED*delta

func hurt(delta:float):
	hp-=delta*150
	if hp<0.0:
		queue_free()
