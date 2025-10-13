extends Card
class_name SpicyChickenSteak


func player_stat_change(player: Player):
	player.max_health += 5

func player_stat_revert(player: Player):
	player.max_health -= 5

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		GameEvents.card_append(SpicyChickenSteak.new())
		applied = true

func card_added():
	bullet_scripts = [
		ReverseBullet.new()
	]
	print(bullet_scripts)
	for i in bullet_scripts:
		print_debug(i)
		GameEvents.add_bullet_mod(i)
