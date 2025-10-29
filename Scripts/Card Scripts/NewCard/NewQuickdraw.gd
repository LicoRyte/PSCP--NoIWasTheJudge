extends CardResource
class_name NewQuickdraw

var bulllet:float = 7
var fire_rate:float = 0.5
const QUICKDRAW = preload("res://Asset/pic/Card/Quickdraw.png")

func _init() -> void:
	_set_name("I Need More Bullet")
	_set_description("Bullet magazines will be larger.")
	_set_stat_name("Bullet + 7")
	_set_image(QUICKDRAW)
	_add_mod(Upgrade.new())

func _gun_change(gun:Gun):
	print("BULLETTTTTTTTTTT!")
	gun.extra_bullet = bulllet
	gun.reduce_fire_rate = fire_rate
	gun.change_fire_rate()
