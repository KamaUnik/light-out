extends CharacterBody2D

@export var SPEED = 300
@export var JMP = -800
@export var gravity = 2000
@onready var interactable : Area2D = $Interactable
var movable = true
var commandable = true
var direction = 0;

func _physics_process(delta: float):
	const_move(delta)
	if (movable):
		movement(delta)
	

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	if(movable):
		movable = false
	commandable = not commandable

func movement(delta):
	if not is_on_floor():
		velocity.y += gravity*delta
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JMP
	if Input.is_action_just_pressed("a") or Input.is_action_just_pressed("d"):
		direction =Input.get_axis("a","d")
	if Input.is_action_just_pressed("s") :
		direction = 0
	move_and_slide()

func const_move(delta):
	velocity.x = direction* SPEED
