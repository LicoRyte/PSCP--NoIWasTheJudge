extends Node
class_name StatComponent


@export_category("Node")
@export var status_component : StatusComponent


@export_category("Parameter")
@export var base_defense : float
@export var base_speed : float

var defense_multiplier: float = 1.0
var speed_multiplier: float = 1.0

func _ready() -> void:
	status_component = Common.get_component(get_parent(), StatusComponent)


func getStatusMultiplier():
	if not status_component:
		return
	var stat = status_component.getMultiplier()
	defense_multiplier = defense_multiplier + stat["defense"] 
	speed_multiplier = speed_multiplier + stat["speed"]
	#in format of 1 + stat in which stat start at 0

func calculate_output(attack: Attack):
	if status_component:
		status_calculation(attack)
	else:
		non_status_calculation(attack)
	return attack

func non_status_calculation(attack : Attack):
	return attack

func status_calculation(attack : Attack):
	return attack
