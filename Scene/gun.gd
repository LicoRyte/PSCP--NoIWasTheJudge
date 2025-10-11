extends Node2D

const bullet = preload("res://Scene/bullet.tscn")
#@onready var sprite: AnimatedSprite2D = $".."
var sprite : Node2D
@onready var marker: Marker2D = $Marker2D #ปากปืน
func _ready() -> void:
	sprite = get_parent()


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	global_position = sprite.global_position

# player หันเกิน 90 สลับด้านปืน
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees <= 270:
		scale.y = -1
	else:
		scale.y = 1

# คลิกซ้ายแล้วใส่กระสุนเข้ามาใน node
	if Input.is_action_just_pressed("Lmb"):
		var bullet_instance = bullet.instantiate()
		get_parent().get_parent().get_parent().add_child(bullet_instance)
		bullet_instance.global_position = marker.global_position
		bullet_instance.rotation = rotation
