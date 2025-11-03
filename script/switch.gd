extends Node2D

var State:bool =false

func toggle_state():
	var sprite = $Sprite2D
	sprite.frame = 1 - sprite.frame
	State = not State

func state():
	return State
