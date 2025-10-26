extends CharacterBody2D
class_name Entity
"""Base Class ของทุกๆ สิ่งๆ ที่สามารถรับ damage รับ status effect ได้"""

signal _entity_died
signal _object_died

var status_effect = {
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

func _process(delta: float) -> void:
	_UpdateMultiplier()
	_CalculateMultiplier()


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
