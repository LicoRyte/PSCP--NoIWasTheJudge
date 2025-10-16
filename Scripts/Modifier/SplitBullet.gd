extends BulletModifier
class_name SplitBullet

@export var cloned_bullets: int = 2
@export var spread_angle: float = 15.0

func on_spawn(bullet: Bullet):
	bullet.extra_damage -= 2
	print("Should Split")
	for i in range(cloned_bullets):
		var clone = bullet.duplicate()
		var angle_offset = deg_to_rad(spread_angle * (i - (cloned_bullets - 1) / 2.0))
		clone.rotation += angle_offset
		clone.global_position = bullet.global_position
		bullet.get_parent().add_child(clone)
