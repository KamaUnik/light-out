extends CanvasLayer
#signal play_call
var next_scene = "res://scenes/level_select.tscn"
@onready var animplay = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animplay.play("start")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_playbutton_pressed() -> void:
	animplay.play("Hide")
	
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hide":
		print("New scene from title")
		get_parent().load_level(next_scene)
