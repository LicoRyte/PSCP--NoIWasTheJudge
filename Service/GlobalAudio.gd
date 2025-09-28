extends Node

var effect = {
	"test" : "put a audio files here"
}

var music = {
	"test_music": "put a files here though"
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
	
