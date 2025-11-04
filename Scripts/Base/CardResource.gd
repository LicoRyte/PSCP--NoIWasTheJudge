extends Resource
class_name CardResource


@export var card_name: String
@export var card_description: String
@export var card_stat: String

@export var card_image: Texture2D

var modifier = [
]

func _health_change(health : HealthComponent):
	health._add_current_health(15)
func _stat_change(stat: StatComponent):
	pass
func _gun_change(gun:Gun):
	pass

func _add_mod(mod : BulletModifier):
	modifier.append(mod)

func execute_modifier():
	for i in modifier:
		GameEvents.add_bullet_mod(i)

"""GET n SETTER"""
func _get_name():
	return card_name

func _get_description():
	return card_description

func _get_stat():
	return card_stat

func _set_name(name : String, and_return : bool = false):
	card_name = name
	if and_return:
		return card_name
func _set_description(name : String, and_return : bool = false):
	card_description = name
	if and_return:
		return card_description

func _set_stat_name(name : String, and_return : bool = false):
	card_stat = name
	if and_return:
		return card_stat
func _set_image(image : Texture2D):
	card_image = image
