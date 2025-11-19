extends CharacterBody2D

const SPEED = 300.0
@export var hp:float = 100.0

func _physics_process(_adelta: float) -> void:
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.get_collider().name)
		if collision.get_collider().name == "Player":
			collision.get_collider().hurt()

func hurt(delta:float):
	hp-=delta*70
	if hp<0.0:
		queue_free()
