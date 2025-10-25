extends CardResource
class_name NewBackfire

var added_health:  float = 15
const BACKFIRE = preload("uid://bj0uc0poslc66")


func _init() -> void:
	_set_name("Backfire")
	_set_description("Bullets will travel the opposite way")
	_set_stat_name("DMG +4")
	_set_image(BACKFIRE)
	_add_mod(ReverseBullet.new())

func _health_change(health : HealthComponent):
	print("Health Problably Got Changed")
	health._add_max_health(added_health)
	print(health._get_health())
