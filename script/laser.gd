extends RayCast2D

## Speed at which the laser extends when first fired, in pixels per second.
@export var cast_speed := 7000.0
## Maximum length of the laser in pixels.
@export var max_length := 1400.0
## Distance in pixels from the origin to start drawing and firing the laser.
@export var start_distance := 20.0
## Base duration of the tween animation in seconds.
@export var growth_time := 0.05
@export var color := Color.WHITE: set = set_color
@onready var casting_particles: GPUParticles2D = $CastingParticles2D
@onready var collision_particles: GPUParticles2D = $CollisionParticles2D
@onready var beam_particles: GPUParticles2D = $BeamParticles2D
@onready var light: Light2D = $light
@onready var sound: AudioStreamPlayer = $sound


## If `true`, the laser is firing.
@export var is_casting := false: set = set_is_casting

var tween: Tween = null

@onready var line_2d :Line2D = $Line2D
@onready var line_width := line_2d.width

func _ready() -> void:
	light.enabled=false
	beam_particles.emitting = false
	collision_particles.emitting = false
	casting_particles.emitting = false
	set_color(color)
	set_is_casting(is_casting)
	line_2d.set_point_position(0,Vector2.RIGHT * start_distance)
	line_2d.set_point_position(1,Vector2.ZERO)
	line_2d.visible = false
	casting_particles.position = line_2d.points[0]

	if not Engine.is_editor_hint():
		set_physics_process(false)


func _physics_process(delta: float) -> void:
	target_position.x = move_toward(
		target_position.x,
		max_length,
		cast_speed * delta
	)

	var laser_end_position := target_position
	force_raycast_update()

	if is_colliding():
		laser_end_position = to_local(get_collision_point())
		collision_particles.global_rotation = get_collision_normal().angle()
		collision_particles.position = laser_end_position
		if str(get_collider()) == 'Enemy':
			get_collider().hurt(delta)
			#pass

	line_2d.set_point_position(1,laser_end_position)
	var laser_start_position := line_2d.points[0]
	beam_particles.position = laser_start_position + (laser_end_position - laser_start_position) * 0.5
	beam_particles.process_material.emission_box_extents.x = laser_end_position.distance_to(laser_start_position) * 0.5

	collision_particles.emitting = is_colliding()


func set_is_casting(new_value: bool) -> void:
	if is_casting == new_value:
		return
	is_casting = new_value

	set_physics_process(is_casting)
	if beam_particles == null:
		return

	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	light.enabled=is_casting

	if not line_2d:
		return

	if is_casting:
		var laser_start := Vector2.RIGHT * start_distance
		line_2d.set_point_position(0,laser_start)
		line_2d.set_point_position(1,laser_start)
		casting_particles.position = laser_start
		sound.play()
		appear()
	else:
		target_position = Vector2.ZERO
		collision_particles.emitting = false
		sound.stop() 
		disappear()


func appear() -> void:
	line_2d.visible = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line_2d, "width", line_width, growth_time * 5.0).from(0.0)


func disappear() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line_2d, "width", 0.0, growth_time).from_current()
	tween.tween_callback(line_2d.hide)


func set_color(new_color: Color) -> void:
	color = new_color
	if line_2d == null:
		return
	line_2d.modulate = new_color
	casting_particles.modulate = new_color
	collision_particles.modulate = new_color
	beam_particles.modulate = new_color
	light.color = new_color
