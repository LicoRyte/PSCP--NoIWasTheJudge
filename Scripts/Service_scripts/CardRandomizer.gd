extends Node2D

@onready var selector_ui: CanvasLayer = $SelectorUI
@onready var card_name: Label = $SelectorUI/Control/VBoxContainer/Card/PanelContainer2/Label
@onready var card_des: Label = $SelectorUI/Control/VBoxContainer/Description/PanelContainer2/Label
@onready var card_stat: Label = $SelectorUI/Control/VBoxContainer/tag/PanelContainer2/Label
@onready var grid: Node2D = $SelectorUI/CardGrid
@onready var available_slots := grid.get_children()

signal _game_continue

var current_card_on_screen = []

var card_storage = [
	NewBackfire.new(),
	NewSpicySteak.new(),
	NewCatWalk.new(),
	NewQuickdraw.new(),
	ColdSteak.new(),
	NewSplitBullet.new()
]


var blacklist = []

enum sequence_flow { CONTINUE, SELECTION, BEFORE_CONTINUE }
var current_sequence = sequence_flow.CONTINUE


func _ready() -> void:
	GameEvents._card_description.connect(update_label)
	GameEvents._reward_sequence.connect(reward_sequence)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("DevTest"):
		GameEvents._reward_sequence.emit()

	match current_sequence:
		sequence_flow.CONTINUE:
			_game_continue.emit()
		sequence_flow.SELECTION:
			show_card(card_storage)
			to(sequence_flow.BEFORE_CONTINUE)
		sequence_flow.BEFORE_CONTINUE:
			pass


func reward_sequence():
	to(sequence_flow.SELECTION)


func to(new_sequence: sequence_flow):
	current_sequence = new_sequence


func show_card(pool: Array) -> void:
	selector_ui.visible = true
	clear_card_from_screen()

	var pickable = pool.duplicate()
	pickable.shuffle()

	for i in range(min(available_slots.size(), pickable.size())):
		var slot = available_slots[i]
		var card_area: CardAreaComponent = Common.get_component(slot, CardAreaComponent)
		if not card_area:
			continue
		card_area.set_card(pickable[i])
		if not card_area.chosen.is_connected(_on_card_selected):
			card_area.chosen.connect(_on_card_selected)
		current_card_on_screen.append(card_area)

func _on_card_selected(card: CardResource) -> void:
	GameEvents.card_append(card)
	selector_ui.visible = false
	clear_card_from_screen()
	to(sequence_flow.CONTINUE)


func clear_card_from_screen():
	for card_area: CardAreaComponent in current_card_on_screen:
		#card_area.get_parent().visible = false
		card_area.set_card(null)
	current_card_on_screen.clear()


func update_label(name: String, des: String, tag: String):
	card_name.text = name
	card_des.text = des
	card_stat.text = tag
