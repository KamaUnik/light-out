extends Node2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
@onready var light = $PointLight2D
@onready var detect = $VisionCone
@onready var laser = $laser
var light_state = false
var usable = true

func toggle_state():
	light_state = not light_state
	if(not laser.is_casting):
		light.enabled = not light.enabled
		detect.monitoring = not detect.monitoring
	
func firing_laser(state: bool):
	laser.set_is_casting(state)
	if(state or not usable):
		light.enabled=false
		detect.monitoring = false
	else:
		light.enabled = light_state
		detect.monitoring = light_state

#func detect_sensor():
	#if Input.is_action_just_pressed("f"):
		#light.enabled = not light.enabled
		#detect.monitoring = not detect.monitoring
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#detect_sensor()

func is_usable(state:bool):
	usable = state
	

func _on_vision_cone_body_entered(body: Node2D) -> void:
	var origin = $"."
	body.enter_zone(origin)

func _on_vision_cone_body_exited(body: Node2D) -> void:
	var origin = $"."
	body.exit_zone(origin)
