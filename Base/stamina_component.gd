extends Node


@export var max_stamina: float = 100.0
var current_stamina = max_stamina


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
	
