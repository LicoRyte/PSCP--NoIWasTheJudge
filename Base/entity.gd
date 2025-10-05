extends CharacterBody2D
class_name Entity
"""Base Class ของทุกๆ สิ่งๆ ที่สามารถรับ damage รับ status effect ได้"""



var status_effect = {
	
}

var current_flame_duration: float

func _ready() -> void:
	Damage._inflict_flame.connect(placeholder)
	
func HasEffect(effect: String) -> bool:
	if status_effect.has(effect):
		return true
	return false

func placeholder():
	pass
