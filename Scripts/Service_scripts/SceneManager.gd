extends Node

var root_scene : String = "res://Scene/Game Scene/"
var tscn : String = ".tscn"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wave_label: Label = $Control/MarginContainer/Label


func _ready() -> void:
	Wave.new_wave.connect(update_wave_text)

func play_summary() -> void:
	var sum_scene = preload("uid://ctl5uoqi234tf")
	var new_sum = sum_scene.instantiate()
	get_tree().current_scene.add_child(new_sum)



func change_scene(scene_name: String):
	animation_player.play("Transit")
	await animation_player.animation_finished
	await get_tree().create_timer(2.0).timeout
	get_tree().call_deferred("change_scene_to_file", root_scene + scene_name + tscn)

	animation_player.play_backwards("Transit")
	await  animation_player.animation_finished

static func create_player(pos : Vector2) -> Node2D:
	var player_scene = preload("uid://cy62k0nefobxq")
	var new_player = player_scene.instantiate()
	new_player.global_position = pos
	return new_player


static func create_enemy(pos: Vector2) -> Node2D:
	var enemy_scene = preload("uid://b35l4f10a5hx4")
	var new_en = enemy_scene.instantiate()
	new_en.global_position = pos
	return new_en

static func create_boss(pos : Vector2) -> Node2D:
	var boss_scene = preload("uid://ub8xljt2csls")
	var new_boss = boss_scene.instantiate()
	new_boss.global_position = pos
	return new_boss

func update_wave_text(wave: int):
	wave_label.modulate.a = 255
	wave_label.text = "--- " + "Wave " + str(wave) + " ---"
	await get_tree().create_timer(4.0).timeout
	wave_label.modulate.a = 0
