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
