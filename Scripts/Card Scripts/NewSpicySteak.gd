extends CardResource
class_name NewSpicySteak

const SPICY_STEAK = preload("uid://cfqk73bfcwysk")

func _init() -> void:
	_set_name("Spicy Steak")
	_set_description("Inflict enemies on fire!")
	_set_stat_name("deal 2 damage over 2 second")
	_set_image(SPICY_STEAK)
	_add_mod(FlameBullet.new())
