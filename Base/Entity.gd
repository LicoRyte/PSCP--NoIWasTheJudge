extends CharacterBody2D
class_name Entity
"""Base Class ของทุกๆ สิ่งๆ ที่สามารถรับ damage รับ status effect ได้"""

signal _entity_died

var status_effect = {
	"flame" : {
		"Damage" : 5,
		"Duration" : 3,
		"Tick" : 0.35,
		"Timer" : 0.0
	}
}


#var flame_time_counter: float = 0.0


"""Enity Stats"""
@export var max_health: float = 100.0
var current_health: float = 0.0
var base_move_speed = 1.0
var base_damage = 1.0
var base_defense = 1.0
var is_died: bool = false

var current_speed_multiplier: float
var current_damage_multiplier: float
var current_defense_multiplier: float

var total_dmg_mul: float
var total_defense_mul: float
var total_speed_mul: float

func _ready() -> void:
	current_health = max_health
	Damage._deal_damage.connect(recieve_damage)
	
	#Status Effect
	Damage._inflict_flame.connect(Status_Append)
	Damage._inflict_freeze.connect(Status_Append)

func _process(delta: float) -> void:
	_UpdateMultiplier()
	_UpdateEffect(delta)
	_CalculateMultiplier()

func recieve_damage(amount: float, target: Entity, source : Node = null) -> void:
	if target == self:
		current_health -= amount
		print(current_health)
	current_health = clamp(current_health, 0, max_health)
	if current_health <= 0:
		_entity_died.emit()

func HasEffect(effect: String) -> bool:
	return status_effect.has(effect)

func HasAttributes(effect: String, att: String) -> bool:
	return status_effect[effect].has(att)

func Status_Append(effect_name: String, attributes: Dictionary, reciever: Entity):
	if reciever != self or HasEffect(effect_name):
		return
	status_effect[effect_name] = attributes
	status_effect[effect_name]["Timer"] = 0.0

func _UpdateEffect(delta: float):
	for name in status_effect.keys():
		var effect = status_effect[name]
		effect["Duration"] -= delta

		if HasAttributes(name, "Tick"):
			effect["Timer" ] += delta
			
			if effect["Timer"] >= effect["Tick"]:
				effect["Timer"] -= effect["Tick"]
				recieve_damage(effect['Damage'], self)

		if effect["Duration"] <= 0:
			status_effect.erase(name)
			continue

		status_effect[name] = effect

func _CalculateMultiplier():
	total_defense_mul = 0
	total_dmg_mul = 0
	total_speed_mul = 0
	
	for e in status_effect.values():
		total_dmg_mul += e.get("Damage_Multiplier", 0.0)
		total_defense_mul += e.get("Defense", 0.0)
		total_speed_mul += e.get("Move_Speed", 0.0)
	total_speed_mul = clamp(total_speed_mul, -1,10)

func _UpdateMultiplier():
	current_damage_multiplier = base_damage * (1.0 + total_dmg_mul)
	current_speed_multiplier = base_move_speed * (1.0 + total_speed_mul)
	current_defense_multiplier = base_defense * (1.0 + total_defense_mul)
