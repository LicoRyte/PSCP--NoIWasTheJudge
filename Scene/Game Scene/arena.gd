extends Node2D

var current_player : Player
func _ready() -> void:
	current_player = SceneManager.create_player(Vector2(100,100))
	add_child(current_player)
	GameEvents._game_start.emit()
