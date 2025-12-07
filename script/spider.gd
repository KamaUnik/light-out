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
	rotation = (next_pos- global_position).angle() -PI/2
	global_position = global_position.move_toward(next_pos,delta*SPEED)
	if global_position == next_pos:
		current_pos = (current_pos+1)% poschildren.size()
