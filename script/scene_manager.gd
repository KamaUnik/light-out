extends Node2D


# Called when the node enters the scene tree for the first time.
func load_level(next_scene: String):
	get_child(0).queue_free()
	var next_scene_load = load(next_scene).instantiate()
	print("New Scene!")
	add_child(next_scene_load)
	get_child(0).name = "LevelRoot"
