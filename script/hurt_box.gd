class_name HurtBox
extends Area2D

signal received_damage()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered",_on_area_entered)
	connect("body_entered",_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_area_entered(_hitbox: Hitbox):
	received_damage.emit()


func _on_body_entered(_body):
	received_damage.emit()
