extends Node



func fx(sfx: AudioStream):
	var player = AudioStreamPlayer.new()
	player.stream = sfx
	add_child(player)
	player.play()
	await player.finished
	remove_child(player)

func global_music(music : AudioStream):
	pass
	
