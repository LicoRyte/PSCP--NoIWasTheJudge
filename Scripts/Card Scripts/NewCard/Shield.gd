extends CardResource
class_name Shield

'''const SHIELD = preload("")'''
func _init() -> void:
	_set_name("Strong Shield")
	_set_description("The bullet will split into three pieces.")
	_set_stat_name("DEF + 10")
	'''_set_image(SHIELD)'''

func _stat_change(stat: StatComponent):
	print("DEF + 10!!!!!!!!!!!!!!!!!!!!!!")
	stat.defense_multiplier += 10
