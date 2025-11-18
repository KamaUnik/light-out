extends CharacterBody2D

const SPEED = 300.0
@export var hp:float = 100.0

#func _physics_process(delta: float) -> void:
	#pass

func hurt(delta:float):
	hp-=delta*70
	if hp<0.0:
		queue_free()
