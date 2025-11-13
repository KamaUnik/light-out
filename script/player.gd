extends CharacterBody2D
 
@export var SPEED = 400
@export var JMP = -800
@export var gravity = 2000
@onready var flashlight := $RotF/Flashlight
@onready var cooldownTimer: Timer = $CooldownTimer
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_cooling = false
var fuel = 10
@export var maxfuel = 10

func refill_fuel():
	fuel = maxfuel

func firing_laser(delta:float):
	var is_firing_laser=false
	
	if fuel > 0:
		if Input.is_action_pressed("leftclick"):
			fuel-= 10*delta
			is_firing_laser=true
			push_player()
		else:
			fuel+=10*delta
			if fuel>maxfuel:
				fuel = maxfuel
	else:
		fuel = 0
		if not is_cooling:
			cooldownTimer.start()
			is_cooling =true
	flashlight.firing_laser(is_firing_laser)
	print(fuel)


func push_player():
	var add_v = (get_global_mouse_position() - global_position).normalized()*50
	velocity.x = velocity.x-add_v.x
	if (not is_on_floor()):
		velocity.y = velocity.y-add_v.y


func _physics_process(delta: float):

	if not is_on_floor():
		velocity.y += gravity*delta
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JMP
	if Input.is_action_just_pressed("f"):
		flashlight.toggle_state()
	
	var direction =Input.get_axis("a","d")
	if direction:
		velocity.x = direction* SPEED
	else:
		velocity.x=move_toward(velocity.x,0,SPEED)
		
	firing_laser(delta)
	move_and_slide()
	

func _on_room_detector_area_entered(area: Area2D):
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	var view_size = get_viewport_rect().size
	if size.y < view_size.y:
		size.y = view_size.y
		
	if size.x < view_size.x:
		size.x = view_size.x
	
	var cam = $Camera2D
	cam.limit_top = collision_shape.global_position.y - size.y/2
	cam.limit_left = collision_shape.global_position.x - size.x/2
	
	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x
#


func _on_cooldown_timer_timeout() -> void:
	refill_fuel()
