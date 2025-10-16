extends BulletModifier 

class_name Upgrade


func _ready() -> void:
	pass

func on_spawn(bullet: Bullet):
	bullet.extra_damage += 3

func on_active(bullet, delta):
	bullet.base_bullet_speed += 100 * delta
