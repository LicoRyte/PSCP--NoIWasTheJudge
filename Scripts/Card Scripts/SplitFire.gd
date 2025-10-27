extends Card
class_name SplitFire

func player_stat_change(player: Player):
	pass

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not applied:
		chosen.emit(SplitFire.new())
		applied = true


func card_added():
	bullet_scripts = [
		SplitBullet.new()
	]
	for i in bullet_scripts:
		GameEvents.add_bullet_mod(i)

func gun_stat_change(gun:Gun):
	gun.reduce_fire_rate -= 0.3

func _on_area_2d_mouse_entered() -> void:
	GameEvents._card_description.emit(card_name, card_description, stat_change)


func _on_area_2d_mouse_exited() -> void:
	GameEvents._card_description.emit("", "", "")
