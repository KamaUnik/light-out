extends Node2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#

func toggle_light():
	var light = $PointLight2D
	var detect = $VisionCone
	if Input.is_action_just_pressed("f"):
		light.enabled = not light.enabled
		detect.monitoring = not detect.monitoring
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	toggle_light()


func _on_vision_cone_body_entered(body: Node2D) -> void:
	var origin = $"."
	body.enter_zone(origin)

func _on_vision_cone_body_exited(body: Node2D) -> void:
	var origin = $"."
	body.exit_zone(origin)
