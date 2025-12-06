extends Node2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
var is_dead = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dead:
		return
	rotation = lerp_angle(rotation,(get_global_mouse_position() - global_position).angle(),50*delta)
	

func player_is_dead():
	is_dead=true
