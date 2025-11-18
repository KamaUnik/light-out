extends TextureRect

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer
var state = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.frame = 0

func change_state(new_state:bool):
	if(state == new_state):
		return
	if(new_state):
		heal()
	else:
		hurt()
	state = new_state

func hurt():
	anim.play("hurt")

func heal():
	anim.play("heal")
