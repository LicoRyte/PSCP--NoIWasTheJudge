extends Node2D
class_name Enemy_bullet

@export var speed: float = 400.0
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	global_position += velocity * delta * 0.5

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Enemy or area.get_parent() is Enemy_bullet or area.get_parent() is Bullet:
		return
	Damage.deal_damage(3.0, area.get_parent())
	queue_free()
