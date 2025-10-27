extends Node
class_name StatusComponent

@export var entity: HealthComponent

var current_effect : Dictionary = {
	#5 "Flame" 0.35 2 2
}
var output_defense: float = 0.0
var output_speed: float = 0.0


func _ready() -> void:
	entity = Common.get_component(get_parent(), HealthComponent)

func _process(delta: float) -> void:
	updateCurrent(delta)


func hasEffect(effect_name: String) -> bool:
	return current_effect.has(effect_name)

func addEffect(effect : Effect): 
	if hasEffect(effect.effect_name):
		current_effect.get(effect.effect_name).duration = effect.refresh(effect.duration)
	else:
		current_effect[effect.effect_name] = effect

func updateCurrent(delta : float):
	for name in current_effect.keys():
		var effect: Effect = current_effect[name] #5 "Flame" 0.35 2 2
		if effect.effect_update(delta):
			pass
		if effect.is_expired():
			remove_effect(name)

func remove_effect(effect_name : String):
	current_effect.erase(effect_name)

func getMultiplier():
	var defense_sum: float = 1.0
	var speed_sum: float = 1.0
	var damage_sum: float = 1.0

	for eff: Effect in current_effect.values():
		defense_sum += eff.get_defense_value() #5 "Flame" 0.35 2 2
		speed_sum += eff.get_speed_value() #1 + 2 = 3
		damage_sum += eff.get_damage_value()

	return {
		"defense": defense_sum,
		"speed": speed_sum, #3
		"damage": damage_sum
	}
