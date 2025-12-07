class_name level
extends Node2D

@export var level_name :String
@export var this_scene_path: String
@onready var gameoverscreen: CanvasLayer = $GameOver
@onready var goalscreen: CanvasLayer = $GoalScreen
@onready var animplayer: AnimationPlayer = $AnimationPlayer
var resetting = false
const level_select_scene_path = "res://scenes/level_select.tscn"

func _ready():
	animplayer.play("show")

func _on_player_player_died() -> void:
	gameoverscreen.activate()

func _on_player_player_goal() -> void:
	goalscreen.activate()

func _on_game_over_retry_pressed() -> void:
	resetting = true
	animplayer.play("hide")

func _on_goal_screen_retry_pressed() -> void:
	resetting=true
	animplayer.play("hide")

func _on_game_over_level_select_pressed() -> void:
	animplayer.play("hide")
	
func _on_goal_screen_level_select_pressed() -> void:
	animplayer.play("hide")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name =="hide":
		if resetting:
			get_parent().load_level(this_scene_path)
		else:
			get_parent().load_level(level_select_scene_path)
