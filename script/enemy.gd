extends CharacterBody2D


const SPEED = 600.0
@export var hp:float = 100.0
@onready var ray_r = $Rayright
@onready var ray_bot_r = $Raybottomright
@onready var ray_l = $RayLeft
@onready var ray_bot_l = $Raybottomleft
@onready var animsprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var deathaudio = $Death
@onready var walkaudio = $walk
@onready var timer=$Deathtimer
var direction = 1
var is_dead = false
func _to_string():
	return "Enemy"


func _physics_process(delta: float) -> void:
	if is_dead:
		walkaudio.stop()
		return
	if !walkaudio.playing:
		walkaudio.play()
	if ray_r.is_colliding() or not ray_bot_r.is_colliding():
		direction = -1
	if ray_l.is_colliding() or not ray_bot_l.is_colliding():
		direction = 1
	animsprite.flip_h = (direction==-1)
	position.x += direction*SPEED*delta

func hurt(delta:float):
	hp-=delta*150
	if hp<0.0 and not is_dead:
		death()

func death():
	is_dead = true
	hitbox.monitorable = false
	animsprite.flip_v = true
	deathaudio.play()
	timer.start()

func _on_deathtimer_timeout() -> void:
	queue_free()
