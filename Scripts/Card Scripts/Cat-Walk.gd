extends Card
class_name CatWalk


func player_stat_change(player: Player):
	player.move_speed += 35
	print(player.move_speed)

func player_stat_revert(player: Player):
	player.move_speed -= 35

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		GameEvents.card_append(CatWalk.new())
		applied = true

func card_added():
	pass

func card_removed():
	pass
