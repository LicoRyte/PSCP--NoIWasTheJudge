extends Card

class_name Gun_upgrade

func player_stat_change(player: Player):
	player.move_speed += 20

func player_stat_revert(player: Player):
	player.move_speed -= 20

func gun_stat_change(gun:Gun):
	gun.extra_bullet += 7
	gun.reduce_fire_rate = 0.2
	gun.change_fire_rate()

func  gun_stat_revert(gun:Gun):
	gun.extra_bullet -= 7
	gun.reduce_fire_rate = 0
	gun.change_fire_rate()
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		GameEvents.card_append(Gun_upgrade.new())
		applied = true

func card_added():
	pass

func card_removed():
	pass

func _on_area_2d_mouse_entered() -> void:
	GameEvents._card_description.emit(card_name, card_description, stat_change)


func _on_area_2d_mouse_exited() -> void:
	GameEvents._card_description.emit("", "", "")
