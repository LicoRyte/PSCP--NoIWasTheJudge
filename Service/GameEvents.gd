extends Node


"""เป็นระบบเกมหลัก ใช้ update สถานะเกม ตรวจสอบ Win condition ควบคุมสิ่งที่เกิดขึ้น"""

signal _hpchanged(amount: float)
signal _player_died
signal _card_append(card: Card)
signal _card_description(card_name : String, card_description : String)

signal _bullet_modifier_append(modifier: BulletModifier)

signal _bullet_modifier_remove(modifier: BulletModifier)

var current_mod : Array[BulletModifier] = [
	#ReverseBullet.new()
]
func add_bullet_mod(mod : BulletModifier) -> void:
	current_mod.append(mod)
	_bullet_modifier_append.emit(mod)
	print_debug(current_mod)

func card_append(card: Card):
	_card_append.emit(card)

func update_description(card_name: String, card_description: String):
	_card_description.emit(card_name, card_description)
