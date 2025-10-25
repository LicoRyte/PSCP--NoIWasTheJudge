extends Node
class_name StatComponent


@export_category("Node")
@export var status_component : StatusComponent


@export_category("Parameter")
@export var base_defense : float
@export var base_speed : float

func _ready() -> void:
	status_component = Common.get_component(get_parent(), StatusComponent)


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
