extends Node
class_name StatComponent


@export_category("Node")
@export var status_component : StatusComponent


@export_category("Parameter")
@export var base_defense : float
@export var base_speed : float

var defense_multiplier: float = 1.0
var speed_multiplier: float = 1.0
var damage_multiplier: float = 1.0

func _ready() -> void:
	status_component = Common.get_component(get_parent(), StatusComponent)


func getStatusMultiplier():
	if not status_component:
		return
	var base_defense_mult = 1.0
	var base_speed_mult = 1.0
	var base_damage_mult = 1.0

	var stat = status_component.getMultiplier()
	defense_multiplier = base_defense_mult + stat["defense"] #1 + 1 = 2
	speed_multiplier = base_speed_mult + stat["speed"] #1 + 3 = 4
	damage_multiplier = base_damage_mult + stat["damage"]
	#in format of 1 + stat in which stat start at 0

func calculate_output(attack: Attack):  #5 crit = 2 critmultiplier 25
	var new_attack : Attack # 0 0 0 0
	if status_component:
		new_attack = status_calculation(attack)
	else:
		new_attack = non_status_calculation(attack)
	return new_attack

func non_status_calculation(attack : Attack):
	return attack

func status_calculation(attack : Attack):
	getStatusMultiplier()
	attack.damage = attack.get_damage() - (base_defense * defense_multiplier)
	return attack
