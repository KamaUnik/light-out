extends CanvasLayer

@onready var screen: Panel = $Screen
@onready var rect: Panel = $rect
@onready var label: Label = $rect/Label
@onready var retry : Button = $rect/Retry
@onready var animplay: AnimationPlayer = $AnimationPlayer
signal retry_pressed
signal level_select_pressed
var is_activated = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pausemenu"):
		is_activated = not is_activated
		if is_activated:
			activate()
		else:
			deactivate()

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
	
func deactivate():
	animplay.play("deactivate")

func _on_retry_pressed() -> void:
	retry_pressed.emit()

func _on_levelselect_pressed() -> void:
	level_select_pressed.emit()

func _on_quit_pressed() -> void:
	get_tree().quit()
