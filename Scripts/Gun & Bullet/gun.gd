extends Node2D
class_name Gun

const bullet = preload("res://Scene/Gun & Bullet/bullet.tscn")

var sprite : Node2D
@onready var marker: Marker2D = $Marker2D

@export var max_bullet := 8
@export var fire_rate := 0.3
@export var reload_time := 1.0

var reduce_fire_rate = 0
var extra_bullet = 0

var curr_bullet = max_bullet + extra_bullet
var can_shoot := true
var is_reloading := false

var fire_timer : Timer
var reload_timer : Timer


func _ready() -> void:
	sprite = get_parent()
	fire_timer = Timer.new()
	fire_timer.one_shot = true
	fire_timer.wait_time = fire_rate
	add_child(fire_timer)

	#timer
	reload_timer = Timer.new()
	reload_timer.one_shot = true
	reload_timer.wait_time = reload_time
	add_child(reload_timer)

	fire_timer.timeout.connect(_on_fire_timer_timeout)
	reload_timer.timeout.connect(_on_reload_timer_timeout)


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	global_position = sprite.global_position

	rotation_degrees = wrap(rotation_degrees, 0, 360)
	scale.y = -1 if rotation_degrees > 90 and rotation_degrees <= 270 else 1


	if Input.is_action_pressed("Lmb") and can_shoot and not is_reloading:
		if curr_bullet > 0:
			shoot()
		else:
			start_reload()

	if Input.is_action_just_pressed("Relode") and not is_reloading and curr_bullet < max_bullet:
		start_reload()

func change_fire_rate():
	if fire_timer:
		fire_timer.wait_time = fire_rate - reduce_fire_rate

func shoot() -> void:
	can_shoot = false
	fire_timer.start()

	var bullet_instance = bullet.instantiate()
	get_parent().get_parent().get_parent().add_child(bullet_instance)
	bullet_instance.global_position = marker.global_position
	bullet_instance.rotation = rotation

	curr_bullet -= 1
	print("Shoot! Bullets left:", curr_bullet)

func _on_fire_timer_timeout() -> void:
	can_shoot = true

# Relode Bullet
func start_reload() -> void:
	is_reloading = true
	can_shoot = false
	reload_timer.start()
	print("Reloading...")


func _on_reload_timer_timeout() -> void:
	is_reloading = false
	can_shoot = true
	curr_bullet = max_bullet + extra_bullet
	print("Reload complete! Bullets refilled:", curr_bullet)
