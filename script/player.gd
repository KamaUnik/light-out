extends CharacterBody2D

@export var SPEED = 400
@export var JMP = -400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y += gravity*delta
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JMP
		
	
	var direction =Input.get_axis("a","d")
	if direction:
		velocity.x = direction* SPEED
	else:
		velocity.x=move_toward(velocity.x,0,SPEED)
	
	move_and_slide()
	
