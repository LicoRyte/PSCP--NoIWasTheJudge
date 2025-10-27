extends Node2D


@onready var static_line: Line2D = $static_line

var base_bullet_speed = 125.0
var damage = 30
var swap_time = 0.17
var temp = 0.0

var time_till_delete = 15
func _ready() -> void:
	temp = swap_time


func _process(delta: float) -> void:
	position += transform.x * base_bullet_speed * delta * 1.5
	time_till_delete -= delta
	temp -= delta
	if temp <= 0:
		for i in static_line.points.size():
			var point = static_line.points[i]
			point.x = randi_range(-12, 12)
			static_line.set_point_position(i, point)
		temp = swap_time
	if time_till_delete <= 0:
		queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Damage.deal_damage(damage, body)
