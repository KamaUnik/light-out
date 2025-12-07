extends CanvasLayer

@onready var animplay = $AnimationPlayer
var next_scene: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animplay.play("start")

func load_level(scene_Path:String):
	next_scene = scene_Path
	animplay.play("Hide")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hide":
		get_parent().load_level(next_scene)
