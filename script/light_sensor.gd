extends CharacterBody2D
class_name lightsensor

@export var debugname = "Test"
var target: Node2D
var original_pos: Vector2
var activate:bool = false
var in_area:bool

func _ready() -> void:
	var ray = $RayCast2D
	original_pos = ray.get_target_position()

func _process(delta: float) -> void:
	update_target_pos()
	check_light()
	light_debug()
	
func update_target_pos():
	var ray = $RayCast2D
	if(target != null):
		ray.set_target_position(ray.to_local(target.get_global_position()))
	else:
		ray.set_target_position(original_pos)

func enter_zone(origin: Node2D):
	if(target ==null):
		target = origin
		in_area=true

func exit_zone(origin: Node2D):
	if(origin ==target):
		target=null
		activate=false
		in_area=false

func check_light():
	var ray = $RayCast2D
	if(not ray.is_colliding() and in_area):
		activate=true
	else:
		activate=false

func light_debug():
	var sprite = $Sprite2D
	if(activate):
		sprite.play("Activate")
	else:
		sprite.play("Deactivate")
