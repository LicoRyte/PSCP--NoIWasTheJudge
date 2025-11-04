extends Node


"""เป็นระบบเกมหลัก ใช้ update สถานะเกม ตรวจสอบ Win condition ควบคุมสิ่งที่เกิดขึ้น"""

"""Player Events"""
signal _hpchanged(current_hp: float)
signal _player_died
signal _shake_call
signal _staminachanged(current_stamina: float)
signal _game_start
signal _game_continue
signal _on_stamina_changed(value)

"""Card Events"""
signal _card_append(card: CardResource)
signal _card_description(card_name : String, card_description : String, card_tag: String)
signal _reward_sequence

"""UI"""
signal update_enemy_killed
signal update_card_collected

var enemy_killed = 0
var card_collected = 0

var	player_health:HealthComponent
var current_mod : Array[BulletModifier] = [
]
var game_end : bool = false

func _ready() -> void:
	_player_died.connect(show_summary)

func reset_game():
	reset_mod()
	reset_statistic()
	game_end = false

func reset_statistic():
	enemy_killed = 0
	card_collected = 0

func reset_mod():
	current_mod.clear()

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

func get_enemies_killed():
	return enemy_killed
func get_card_collected():
	return card_collected
	
func show_summary():
	if not game_end:
		SceneManager.play_summary()
		game_end = true
