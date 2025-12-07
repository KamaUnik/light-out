extends TextureButton
@export var labelname: String = "Test"
@export var levelpath: String

func _ready():
	$Label.text = labelname

# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	get_parent().load_level(levelpath)
