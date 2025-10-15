extends Card
class_name SpicySteak


func player_stat_change(player: Player):
	player.max_health += 100

func player_stat_revert(player: Player):
	player.max_health -= 100

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		GameEvents.card_append(SpicySteak.new())
		applied = true

func card_added():
	bullet_scripts = [
		FlameBullet.new()
	]
	for i in bullet_scripts:
		GameEvents.add_bullet_mod(i)

func card_removed():
	pass
