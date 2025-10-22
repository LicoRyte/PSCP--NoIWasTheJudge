extends Node


"""เป็นระบบเกมหลัก ใช้ update สถานะเกม ตรวจสอบ Win condition ควบคุมสิ่งที่เกิดขึ้น"""

"""Player Events"""
signal _hpchanged(current_hp: float)
signal _player_died
signal _shake_call
signal _staminachanged(current_stamina: float)

"""Card Events"""
signal _card_append(card: Card)
signal _card_description(card_name : String, card_description : String, card_tag: String)
signal _reward_sequence
var current_mod : Array[BulletModifier] = [
	#ReverseBullet.new()
]
func card_append(card: Card):
	_card_append.emit(card)

func update_description(card_name: String, card_description: String):
	_card_description.emit(card_name, card_description)

"""Bullet Events"""
func add_bullet_mod(mod : BulletModifier) -> void:
	current_mod.append(mod)

func remove_bullet_mod(mod : BulletModifier) -> void:
	current_mod.erase(mod)
