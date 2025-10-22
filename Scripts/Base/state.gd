extends Node
class_name State

var player : Player
@export var animation_name: String

func enter():
	player.anims.play(animation_name)
func exit():
	pass
func process_physics(delta: float) -> State:
	return null
func process_input(event: InputEvent) -> State:
	return null
