extends Card
class_name CatWalk


func player_stat_change(player: Player):
	player.move_speed += 35
	print(player.move_speed)

func player_stat_revert(player: Player):
	player.move_speed -= 35

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		chosen.emit(CatWalk.new())
		applied = true

func card_added():
	pass

func card_removed():
	pass


func _on_area_2d_mouse_entered() -> void:
	GameEvents._card_description.emit(card_name, card_description, stat_change)


func _on_area_2d_mouse_exited() -> void:
	GameEvents._card_description.emit("", "", "")
