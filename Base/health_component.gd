extends Node


@export var max_health: float = 100.0

signal _player_died

var component_owner: Node2D
var current_health: float

func _ready() -> void:
	component_owner = get_parent()
	current_health = max_health

func set_max_health(amount: float):
	max_health = amount

func change_health(amount: float):
	current_health += amount
	current_health = clamp(current_health, 0, max_health)
	if current_health <= 0:
		_player_died.emit()
		

	
