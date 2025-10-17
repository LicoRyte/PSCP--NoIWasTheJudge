extends Node

"""เป็นระบบเสียงหลัก สามารถเรียกใช้ได้เลยโดยการนำไฟล์เสียงไปใส่ไว้ใน Dict และกำหนด Key ที่เป็น String"""
"""การเรียกใช้คือ fx(string ของ Key เพลงที่ต้องการเรียก)"""
"""รวมถึง Change_music() ด้วย"""

var effect = {
	"test" : "put an audio files here",
	"damage" : preload("uid://cp7eslbjgjbnc"),
	"shoot": preload("uid://dnb2cwhwvqvnl"),
	"killed" : preload("uid://c0jrj35iwfb5s"),
	"beam" : preload("uid://ux5cda518ijw"),
	"spear" : preload("uid://dn1s45xyt4o8e")
}

var music = {
	"test_music": "put an files here though"
}

var current_music: AudioStream
@onready var background_player: AudioStreamPlayer = $BackgroundPlayer
var fade_time = 0.2

func fx(sfx: String):
	var player = AudioStreamPlayer.new()
	player.stream = effect[sfx]
	add_child(player)
	player.play()
	await player.finished
	remove_child(player)
	player.queue_free()

func change_music(new_music: String):
	if current_music != music[new_music]:
		current_music = music[new_music]
		var tween = create_tween()
		# Fade out current music
		tween.tween_property(background_player, "volume_db", -80, fade_time)
		tween.tween_callback(func():
			background_player.stream = music[new_music]
			background_player.volume_db = -15
			background_player.play()
		)
	
func reverb(pitch_scale : float):
	if background_player.stream:
		var tween = create_tween()
		tween.tween_property(background_player, "pitch_scale", pitch_scale, 0.2)
