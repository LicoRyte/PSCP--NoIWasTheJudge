extends Node

"""ไม่ใช้แล้ว แต่เก็บไว้ศึกษาได้"""
"""OK จากไกด์"""

@export var max_stamina: float = 100.0
var current_stamina = max_stamina


var component_owner: Node2D
func _ready() -> void:
	component_owner = get_parent()
func set_max_stamina(amount: float):
	max_stamina = amount

func change_stamina(amount: float):
	current_stamina += amount
	current_stamina = clamp(current_stamina, 0, max_stamina)

func use_stamina(amount: float):
	if current_stamina <= 0 or amount > current_stamina:
		return false
	else:
		return true
	
