extends Node2D
class_name Bullet

const bullet_speed:int = 200

func _process(delta: float) -> void:
	position += transform.x * bullet_speed * delta

# delete bullet ที่ออกขอบจอ
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
