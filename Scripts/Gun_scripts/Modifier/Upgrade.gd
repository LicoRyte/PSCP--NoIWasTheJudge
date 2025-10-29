extends BulletModifier 

class_name Upgrade

var speed : int = 200

func _ready() -> void:
	pass

func on_spawn(bullet: Bullet):
	bullet.extra_damage += 3
	bullet.base_bullet_speed += speed
