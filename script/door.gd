extends Node2D

func open():
	var player = $AnimationPlayer
	player.play("act")
	
func close():
	var player = $AnimationPlayer
	player.play("deact")
