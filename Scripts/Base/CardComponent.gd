extends Node
class_name CardContainerComponent

var health : HealthComponent
var stat : StatComponent

func _ready() -> void:
	health = Common.get_component(get_parent(), HealthComponent)
	stat = Common.get_component(get_parent(), StatComponent)

	GameEvents._card_append.connect(card_added)

	connect("tree_entered", card_added)
	connect("tree_exited", card_removed)

func card_added(card : CardResource):
	card._health_change(health)
	card._stat_change(stat)
	card.execute_modifier()

func card_removed(card: CardResource):
	pass
