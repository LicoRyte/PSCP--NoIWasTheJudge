extends CardResource
class_name NewSplitBullet

const SPLIT_BULLET = preload("res://Asset/pic/Card/SplitFire.png")

func _init() -> void:
	_set_name("Split Bullet")
	_set_description("The bullet will split into three pieces.")
	_set_stat_name("Bullet SPLIT!")
	_set_image(SPLIT_BULLET)
	_add_mod(SplitBullet.new())
