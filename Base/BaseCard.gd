extends Node2D
class_name Card

var bullet_scripts: Array[BulletModifier] = [
	#เอา Modifier ที่เกี่ยวข้องกับ bullet มาใส่ให้การ์ด
	#FlameBullet.new()
]
@export var card_name : String
@export var card_description : String
@export var stat_change : String

var applied = false
func _ready() -> void:
	pass
func player_stat_change(player: Player):
	pass
func player_stat_revert(player: Player):
	pass
func card_added():
	pass
func card_removed():
	for mod in bullet_scripts:
		GameEvents._bullet_modifier_remove.emit(mod)

func scene_added():
	pass
