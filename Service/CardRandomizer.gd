extends Node2D

@onready var selector_ui: CanvasLayer = $"SelectorUI"

@onready var card_name: Label = $SelectorUI/Control/VBoxContainer/Card/PanelContainer2/Label
@onready var card_des: Label = $SelectorUI/Control/VBoxContainer/Description/PanelContainer2/Label
@onready var card_stat: Label = $SelectorUI/Control/VBoxContainer/tag/PanelContainer2/Label
@onready var available_slots = $SelectorUI/CardGrid.get_children() #position (slot1,2,3)

signal _game_continue


var current_card_on_screen = []

var card_storage = [
	preload("uid://d1giuihtglqfc"), #Backfire
	preload("uid://th28212ig6k6"), #Cat-Walk
	preload("uid://cp8404a2y6pjk"), #SpicySteak aka node_2d
	preload("uid://wsm20eare230"), #Upgrade Gun
]

enum sequence_flow {
	CONTINUE, SELECTION, BEFORE_CONTINUE
}




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
			to(sequence_flow.CONTINUE)


func reward_sequence():
	to(sequence_flow.SELECTION)

func to(new_sequence: sequence_flow):
	current_sequence = new_sequence

func show_card(array_of_card : Array):
	print(array_of_card)
	selector_ui.visible = true
	clear_card_from_screen()
	var pickable = array_of_card.duplicate()
	pickable.shuffle()
	
	for i in range(available_slots.size() - 1):
		var card = pickable[i].instantiate()
		card.position = available_slots[i].global_position
		card.chosen.connect(_on_card_selected)
		add_child(card)
		current_card_on_screen.append(card)


func _on_card_selected(card : Card):
	GameEvents.card_append(card)
	for c in current_card_on_screen:
		c.queue_free()
	current_card_on_screen.clear()
	selector_ui.visible = false


func clear_card_from_screen():
	for c in current_card_on_screen:
		if is_instance_valid(c): c.queue_free()
	current_card_on_screen.clear()

func update_label(name : String, des : String, tag : String):
	card_name.text = name
	card_des.text = des
	card_stat.text = tag
