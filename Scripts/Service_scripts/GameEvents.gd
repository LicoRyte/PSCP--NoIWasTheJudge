extends Node


"""เป็นระบบเกมหลัก ใช้ update สถานะเกม ตรวจสอบ Win condition ควบคุมสิ่งที่เกิดขึ้น"""

"""Player Events"""
signal _hpchanged(current_hp: float)
signal _player_died
signal _shake_call
signal _staminachanged(current_stamina: float)

"""Card Events"""
signal _card_append(card: CardResource)
signal _card_description(card_name : String, card_description : String, card_tag: String)
signal _reward_sequence

"""Boss Scene"""
var boss_scene = {
	"GUIDE" : preload("uid://ub8xljt2csls")
}

var	player_health:HealthComponent
var current_mod : Array[BulletModifier] = [
	#ReverseBullet.new()
]

func set_health(health:HealthComponent):
	player_health = health
	
func get_health():
	return player_health

func card_append(card: CardResource):
	_card_append.emit(card)

func update_description(card_name: String, card_description: String, card_tag : String):
	_card_description.emit(card_name, card_description, card_tag)

"""Bullet Events"""
func add_bullet_mod(mod : BulletModifier) -> void:
	current_mod.append(mod)

func remove_bullet_mod(mod : BulletModifier) -> void:
	current_mod.erase(mod)
