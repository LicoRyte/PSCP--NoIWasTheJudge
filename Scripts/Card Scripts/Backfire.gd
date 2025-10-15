extends Card
class_name Backfire


func player_stat_change(player: Player):
	pass

func player_stat_revert(player: Player):
	pass

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		chosen.emit(Backfire.new())
		applied = true

func card_added():
	bullet_scripts = [
		ReverseBullet.new()
	]
	for i in bullet_scripts:
		print_debug(i)
		GameEvents.add_bullet_mod(i)

func card_removed():
	for i in bullet_scripts:
		GameEvents.remove_bullet_mod(i)

func _on_area_2d_mouse_entered() -> void:
	GameEvents._card_description.emit(card_name, card_description, stat_change)


func _on_area_2d_mouse_exited() -> void:
	GameEvents._card_description.emit("", "", "")
