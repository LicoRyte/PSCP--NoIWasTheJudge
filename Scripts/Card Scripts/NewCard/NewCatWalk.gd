extends CardResource
class_name NewCatWalk

var speed:float = 200
const CATWALK = preload("res://Asset/pic/Card/Cat-Walk.png")

func _init() -> void:
	_set_name("CatWalk")
	_set_description("Players will overtake the train.")
	_set_stat_name("SPEED +10")
	_set_image(CATWALK)

func _stat_change(stat: StatComponent):
	print("Move faster")
	stat.speed_multiplier += speed
