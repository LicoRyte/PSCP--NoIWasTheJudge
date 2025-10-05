extends CharacterBody2D
class_name Entity
"""Base Class ของทุกๆ สิ่งๆ ที่สามารถรับ damage รับ status effect ได้"""

signal _player_died

var status_effect = {
	"Placeholder" : {
		"damage" : 3,
		"duration" : 3,
		"tick" : 0.35
	}
}

var flame_target: float = 0.0

@export var max_health: float = 100.0
var current_health: float = 0.0
var is_died: bool = false


func _ready() -> void:
	current_health = max_health
	Damage._deal_damage.connect(recieve_damage)
	Damage._inflict_flame.connect(status_append)

func _process(delta: float) -> void:
	Flame(delta)


func recieve_damage(amount: float, target: Entity, source : Node = null) -> void:
	if target == self:
		current_health -= amount
		#print(current_health)
	current_health = clamp(current_health, 0, max_health)
	if current_health <= 0:
		_player_died.emit()



func HasEffect(effect: String) -> bool:
	return status_effect.has(effect)
func status_append(effect_name: String, damage_duration_tick: Array, reciever: Entity):
	if reciever != self:
		return
	status_effect[effect_name] = {"damage": damage_duration_tick[0], "duration": damage_duration_tick[1], "tick" : damage_duration_tick[2]}

func Flame(delta: float) -> void:
	if not HasEffect("flame"):
		return
	var flame = status_effect["flame"]
	flame["duration"] -= delta
	if flame["duration"] <= 0.0:
		status_effect.erase("flame")
		flame_target = 0.0
		return

	flame_target += delta
	if flame_target >= flame["tick"]:
		flame_target -= flame["tick"]

		#apply_damage(flame["damage"])

	# write back modified dictionary
	status_effect["flame"] = flame
