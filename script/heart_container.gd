extends HBoxContainer

var hp = 3 
var hearts_list : Array[TextureRect]
# Called when the node enters the scene tree for the first time.
func _ready():
	for h in get_children():
		hearts_list.append(h)


func update_value(new_hp: int):
	for i in range(hearts_list.size()):
		hearts_list[i].change_state(i<new_hp)
