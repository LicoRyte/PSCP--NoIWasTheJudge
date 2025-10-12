extends Card
class_name SpicyChickenSteak

func _ready() -> void:
	bullet_scripts = [
		FlameBullet.new()
	]

func player_stat_change(player: Player):
	player.max_health += 5

func player_stat_revert(player: Player):
	player.max_health -= 5

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		for i in bullet_scripts:
			GameEvents.add_bullet_mod(i)
		applied = true
