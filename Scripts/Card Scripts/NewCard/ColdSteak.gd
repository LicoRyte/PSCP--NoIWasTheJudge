extends CardResource
class_name ColdSteak

const COLD_STEAK = preload("res://Asset/pic/Card/ColdSteak.png")

func _init() -> void:
	_set_name("Cold Steak")
	_set_description("Slow down enemy speed!")
	_set_stat_name("deal 1 damage over 3 second")
	_set_image(COLD_STEAK)
	_add_mod(IceBullet.new())
