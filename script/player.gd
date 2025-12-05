extends CharacterBody2D
 
@export var SPEED = 400
@export var JMP = -800
@export var gravity = 2000
@onready var flashlight := $RotF/Flashlight
@onready var cooldownTimer: Timer = $TimerGroup/CooldownTimer
@onready var fuelBar: TextureProgressBar = $FuelBar
@onready var camera: Camera2D = $Camera2D
@onready var Animsprite: AnimatedSprite2D = $AnimatedSprite2D
var hp =3
@onready var healthBar: HBoxContainer = $UI/HeartContainer
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_cooling = false
var fuel = 3.0
@export var maxfuel:float = 3.0
var invul = false
var is_hurt = false
var is_death=false
@onready var invultimer:Timer = $TimerGroup/Invul
@onready var hurttimer:Timer = $TimerGroup/HurtTimer
@onready var animplay: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D



func _ready() -> void:
	fuelBar.max_value = maxfuel

func refill_fuel():
	fuel = maxfuel

var leftclickhold = false
func firing_laser(delta:float):
	var is_firing_laser=false
	if fuel > 0.0:
		if Input.is_action_pressed("leftclick"):
			fuel-= 0.5*delta
			is_firing_laser=true
			if not leftclickhold:
				push_player()
				fuel-= 0.8
			leftclickhold = true
		else:
			leftclickhold = false
			fuel+=0.3*delta
			if fuel>maxfuel:
				fuel = maxfuel
	else:
		fuel = 0.0
		flashlight.is_usable(false)
		if not is_cooling:
			cooldownTimer.start()
			is_cooling =true
	fuelBar.update_value(fuel)
	flashlight.firing_laser(is_firing_laser)


func push_player():
	var add_v = (get_global_mouse_position() - global_position).normalized()*500
	velocity = velocity-add_v



func _physics_process(delta: float):
	if is_death:
		return
	if not is_on_floor():
		velocity.y += gravity*delta
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JMP
	if Input.is_action_just_pressed("f"):
		flashlight.toggle_state()
	
	var direction =Input.get_axis("a","d")
	if direction:
		velocity.x = direction* SPEED
		animplay.play("run")
		#Animsprite.play("run")
	else:
		velocity.x=move_toward(velocity.x,0,SPEED)
		animplay.play("idle")
		#Animsprite.play("idle")	
	
	if not is_on_floor():
		animplay.play("air")
		#Animsprite.play("air")
	
	if is_hurt:
		animplay.play("hurt")
		#Animsprite.play("hurt")
	#Animsprite.flip_h = ((get_global_mouse_position().x - global_position.x))<0
	sprite.flip_h = ((get_global_mouse_position().x - global_position.x))<0
	
	firing_laser(delta)
	move_and_slide()
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#print("Collided with: ", collision.get_collider().name)
	

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
	
	#healthBar.position.y = cam.limit_top+10
	#healthBar.position.x = cam.limit_left+10
	
	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x
#


func _on_cooldown_timer_timeout() -> void:
	fuel+=0.01
	flashlight.is_usable(true)
	is_cooling = false




func hurt():
	if is_death:
		return
	if invul:
		return
	print("Player is hurt")
	hp-=1
	sprite.modulate = Color("red")
	#Animsprite.modulate = Color("red")
	if hp ==0:
		animplay.play("death")
		is_death=true
		print("Player should be dead")
	invul = true
	is_hurt=true
	healthBar.update_value(hp)
	invultimer.start()
	hurttimer.start()
	
	
		
func _on_invul_timeout() -> void:
	invul=false
	#Animsprite.modulate = Color("White")
	sprite.modulate = Color("White")
	print("No longer invul")


func _on_hurt_box_received_damage() -> void:
	hurt()


func _on_hurt_timer_timeout() -> void:
	is_hurt = false
