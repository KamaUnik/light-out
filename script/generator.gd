extends CharacterBody2D

@onready var bar:TextureProgressBar = $Bar
@onready var light:PointLight2D = $PointLight2D
@onready var sprite:Sprite2D =  $Sprite2D
@onready var audio:AudioStreamPlayer = $AudioStreamPlayer
var cap = 5.0
var fill = 0.0
var state = false
func _to_string() -> String:
	return "generator"
# Called when the node enters the scene tree for the first time.

func filling(delta):
	if not bar.visible:
		bar.visible = true
	if fill==cap:
		return
	fill+=delta*2
	if fill > cap:
		fill = cap
		bar.visible = false
		activate()
	bar.value = fill

func activate():
	audio.play()
	sprite.frame=1
	light.enabled=true
	state = true
	get_parent().activate()

func get_state():
	return state
