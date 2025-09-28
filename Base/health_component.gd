extends Node


@export var max_health: float = 100.0

var component_owner: Node2D
var current_health: float

func _ready() -> void:
	component_owner = get_parent()
	current_health = max_health

func set_max_health(amount: float):
	max_health = amount

func change_stamina(amount: float):
	current_health += amount
	current_health = clamp(current_health, 0, max_health)

func use_stamina(amount: float):
	if current_health <= 0 or amount > current_health:
		return false
	else:
		return true
	
