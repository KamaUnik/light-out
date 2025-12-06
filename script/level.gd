class_name level
extends Node2D

@export var level_name :String
@onready var gameoverscreen: CanvasLayer = $GameOver
@onready var goalscreen: CanvasLayer = $GoalScreen
@onready var animplayer: AnimationPlayer = $AnimationPlayer
var resetting = false

func _ready():
	animplayer.play("show")

func _on_player_player_died() -> void:
	gameoverscreen.activate()

func _on_game_over_retry_pressed() -> void:
	resetting = true
	animplayer.play("hide")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name =="hide":
		if resetting:
			gameoverscreen.transition_complete()

func _on_player_player_goal() -> void:
	goalscreen.activate()

func _on_goal_screen_retry_pressed() -> void:
	resetting=true
	animplayer.play("hide")
