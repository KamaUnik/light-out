extends CharacterBody2D
class_name lightsensor

@export var debugname = "Test"
var target: Node2D
var original_pos: Vector2
var activate:bool = false
var in_area:bool

#Light properties
const deact_size =0.25
const deact_color = Color(255,0,0,0.5)
const act_size = 0.50
const act_color =Color(0,255,0,0.5)


func _ready() -> void:
	var ray = $RayCast2D
	original_pos = ray.get_target_position()

func _physics_process(delta: float) -> void:
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
	var light = $PointLight2D
	ray.force_raycast_update()
	if(not ray.is_colliding() and in_area):
		light.color = act_color
		light.texture_scale = act_size
		activate=true
	else:
		light.color = deact_color
		light.texture_scale = deact_size
		activate=false

func getState():
	return activate

func light_debug():
	var sprite = $Sprite2D
	if(getState()):
		sprite.play("Activate")
	else:
		sprite.play("Deactivate")
