extends Node
class_name StatusComponent

@export var entity: HealthComponent

var current_effect : Dictionary = {
	
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
	if hasEffect(name):
		current_effect.get(effect.effect_name).duration = effect.refresh(effect.duration)
	else:
		current_effect[effect.effect_name] = effect

func updateCurrent(delta : float):
	for name in current_effect.keys():
		var effect: Effect = current_effect[name]
		if effect.effect_update(delta):
			pass
		if effect.is_expired():
			remove_effect(name)

func remove_effect(effect_name : String):
	current_effect.erase(effect_name)

func getMultiplier():
	var defense_sum: float = 1.0
	var speed_sum: float = 1.0

	for eff: Effect in current_effect.values():
		defense_sum += eff.get_defense_value()
		speed_sum += eff.get_speed_value()

	return {
		"defense": defense_sum,
		"speed": speed_sum
	}
