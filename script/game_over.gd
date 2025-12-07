extends CanvasLayer

@onready var screen: Panel = $Screen
@onready var rect: Panel = $rect
@onready var label: Label = $rect/Label
@onready var retry : Button = $rect/Retry
@onready var animplay: AnimationPlayer = $AnimationPlayer
signal retry_pressed
signal level_select_pressed

func _ready() -> void:
	visible=false
	screen.modulate = Color(0.0, 0.0, 0.0, 0.0)
	rect.modulate =  Color(0.0, 0.0, 0.0, 0.0)
	label.visible = false
	retry.visible=false
	retry.disabled=true

func activate():
	visible=true
	animplay.play("activate")

func _on_retry_pressed() -> void:
	retry_pressed.emit()

func _on_levelselect_pressed() -> void:
	level_select_pressed.emit()

func _on_quit_pressed() -> void:
	get_tree().quit()
