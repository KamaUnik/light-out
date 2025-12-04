class_name HurtBox
extends Area2D

signal received_damage()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered",_on_area_enterd)


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_area_enterd(_hitbox: Hitbox):
	print("got hit!")
	received_damage.emit()
