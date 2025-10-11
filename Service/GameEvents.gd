extends Node


"""เป็นระบบเกมหลัก ใช้ update สถานะเกม ตรวจสอบ Win condition ควบคุมสิ่งที่เกิดขึ้น"""

signal _hpchanged(amount: float)
signal _player_died
signal _card_append(card: Card)
signal _card_description(card_name : String, card_description : String)
signal _bullet_modifier_append(modifier: BulletModifier)
signal _bullet_modifier_remove(modifier: BulletModifier)

func card_append(card: Card):
	print_debug("Appended")
	_card_append.emit(card)

func update_description(card_name: String, card_description: String):
	_card_description.emit(card_name, card_description)
