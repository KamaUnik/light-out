extends TextureProgressBar

@export var ogColor : Color = Color(1,1,1)
@export var heatColor : Color = Color(1,0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = ogColor

func _process(delta: float) -> void:
	var new_color =ogColor
	if (value/ max_value) > 0.5:
		new_color = ogColor+ (heatColor - ogColor)*(((value/ max_value)-0.5)*2)
	modulate= new_color

func update_value(fuel:float):
	value = max_value - fuel
	#if (value/ maxV) > 0.5:
		#modulate = ogColor+ (heatColor - ogColor)*(value/ maxV)
	#else:
		#modulate = ogColor
	#print(modulate)
