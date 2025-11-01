extends BulletModifier
class_name SplitBullet

@export var cloned_bullets: int = 2
@export var spread_angle_deg: float = 45

func on_spawn(bullet: Bullet) -> void:
	if bullet.has_meta("split_done"):
		return
	bullet.set_meta("split_done", true)
	call_deferred("_do_split", bullet)

func _do_split(bullet: Bullet) -> void:
	if !is_instance_valid(bullet):
		return
	#await get_tree().process_frame
	if !bullet.is_inside_tree():
		return

	var mouse_world := bullet.get_global_mouse_position()
	var base_angle := (mouse_world - bullet.global_position).angle()
	var base_dir := Vector2.RIGHT.rotated(base_angle)

	bullet.set_meta("dir", base_dir)
	bullet.global_rotation = base_angle
	bullet.top_level = true

	var half := (cloned_bullets - 1) / 2.0
	for i in range(cloned_bullets):
		var clone: Bullet = bullet.duplicate()
		clone.modifier = bullet.modifier.filter(func(m): return !(m is SplitBullet))
		clone.set_meta("split_done", true)
		clone.top_level = true
		bullet.get_parent().add_child(clone)
		clone.global_transform = bullet.global_transform
		var angle_offset := deg_to_rad(spread_angle_deg * (i - half))
		var dir := base_dir.rotated(angle_offset)
		clone.set_meta("dir", dir)

		clone.global_rotation = dir.angle()
		clone.base_bullet_speed = bullet.base_bullet_speed / 1.25
		clone.base_damage = bullet.base_damage / 1.25
		clone.extra_damage = bullet.extra_damage
		clone.bullet_duration = bullet.bullet_duration

func on_active(bullet: Bullet, delta: float) -> void:
	if bullet.has_meta("dir"):
		var dir: Vector2 = bullet.get_meta("dir")
		bullet.rotation = dir.angle()
