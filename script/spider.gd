extends CharacterBody2D

@onready var sensor :lightsensor = $LightSensor
@onready var AnimSprites:AnimatedSprite2D = $AnimatedSprite2D
@onready var poschildren:Array[Node] = $"../Pos".get_children()
const SPEED = 300.0
var is_shined = false
var current_pos = 0

func _physics_process(delta: float) -> void:
	if sensor.get_State():
		AnimSprites.play("stop")
		return
	AnimSprites.play("default")
	var next_pos = poschildren[current_pos].global_position
	global_position = global_position.move_toward(next_pos,delta*SPEED)
	if global_position == next_pos:
		current_pos = (current_pos+1)% poschildren.size()


	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
