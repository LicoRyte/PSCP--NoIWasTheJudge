extends BulletModifier 

class_name Upgrade


func _ready() -> void:
	pass

func on_spawn(bullet: Bullet):
	bullet.extra_damage += 3
