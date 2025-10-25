extends Node
class_name StatusComponent

@export var entity: HealthComponent

var current_effect : Dictionary = {
	
}



var defense_multiplier: float = 0.0
var speed_multiplier : float = 0.0


func _ready() -> void:
	entity = Common.get_component(get_parent(), HealthComponent)

func _process(delta: float) -> void:
	updateCurrent(delta)


func hasEffect(effect_name: String) -> bool:
	return current_effect.has(effect_name)

func addEffect(effect : Effect):
	if hasEffect(name):
		current_effect.get(effect.effect_name).duration = effect.duration
	else:
		current_effect[effect.effect_name] = effect

func updateCurrent(delta : float):
	for name in current_effect.keys():
		var effect: Effect = current_effect[name]
		if effect.effect_update(delta):
			print("effect applied")
			apply_effect_damage(effect)
		if effect.is_expired():
			remove_effect(name)

func apply_effect_damage(effect: Effect):
	var att = Attack.new()
	match effect.effect_name.to_lower():
		"flame":
			att.damage = effect.damage
			entity.receive_damage(att)

func remove_effect(effect_name : String):
	current_effect.erase(effect_name)

func getMultiplier(effect_name : String):
	pass
