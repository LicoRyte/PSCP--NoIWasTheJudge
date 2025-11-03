extends Node
class_name HealthComponent

signal health_changed(current_health: float, max_health: float)

var current_health: float
@export var max_health: float

@export var stat_component : StatComponent

func _ready() -> void:
	stat_component = Common.get_component(get_parent(), StatComponent)
	current_health = max_health
	if get_parent() is Player:
		GameEvents.set_health(self)


func receive_damage(attack : Attack, is_magic : bool = false):
	var actual_attack = attack.get_damage() #5
	
	if not is_magic:
		actual_attack = stat_component.calculate_output(attack).get_damage()  #1
	current_health -= actual_attack #100 - 1 = 99
	emit_signal("health_changed", current_health, max_health)
	print(current_health)
	if current_health <= 0:
		if get_parent().has_signal("_object_died"):
			get_parent()._object_died.emit()



func _add_max_health(amount : float, increase_current: bool = false):
	max_health += amount
	if increase_current:
		current_health += amount

func _set_max_health(amount: float):
	max_health = amount

func _set_current_health(amount: float):
	current_health = amount

func _get_health():
	return current_health

func _get_max_health():
	return max_health
