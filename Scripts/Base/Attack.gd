extends Resource
class_name Attack

var damage: float
var crit_chance: float
var crit_multiplier: float
var does_crit : bool = false

func get_damage():
	return damage	


func roll():
	var rand = randf_range(0,100)
	if rand <= crit_chance:
		does_crit = true
		return damage * crit_multiplier
