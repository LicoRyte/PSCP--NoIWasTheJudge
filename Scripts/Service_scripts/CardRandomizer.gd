extends Node2D

@onready var selector_ui: CanvasLayer = $"SelectorUI"

@onready var card_name: Label = $SelectorUI/Control/VBoxContainer/Card/PanelContainer2/Label
@onready var card_des: Label = $SelectorUI/Control/VBoxContainer/Description/PanelContainer2/Label
@onready var card_stat: Label = $SelectorUI/Control/VBoxContainer/tag/PanelContainer2/Label
@onready var available_slots:  = $SelectorUI/CardGrid.get_children() #position (slot1,2,3)
@onready var grid: Node2D = $SelectorUI/CardGrid

signal _game_continue


var current_card_on_screen = []

var card_storage = [
	preload("res://Scene/Card/Backfire.tscn"), #Backfire
	preload("res://Scene/Card/Cat-Walk.tscn"), #Cat-Walk
	preload("res://Scene/Card/node_2d.tscn"), #SpicySteak aka node_2d
	preload("res://Scene/Card/Upgrade Gun.tscn"), #Upgrade_gun
	preload("res://Scene/Card/SplitFire.tscn") #Splitfire 
]

var blacklist = [
	
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

func show_card(pool: Array) -> void:
	selector_ui.visible = true
	clear_card_from_screen()

	var pickable := pool.duplicate()
	pickable.shuffle()

	for i in range(min(available_slots.size(), pickable.size())):
		var scene: PackedScene = pickable[i]
		var card := scene.instantiate()
		card.position = available_slots[i].global_position
		card.set_meta("source_scene", scene)
		card.chosen.connect(_on_card_selected)
		add_child(card)
		current_card_on_screen.append(card)

func _on_card_selected(card: Card) -> void:
	var src: PackedScene = card.get_meta("source_scene")
	if src != null:
		card_storage.erase(src)
		if src not in blacklist:
			blacklist.append(src)


	current_card_on_screen.erase(card)
	GameEvents.card_append(card)

	for c in current_card_on_screen:
		if is_instance_valid(c):
			c.queue_free()
	current_card_on_screen.clear()
	selector_ui.visible = false


	for c in current_card_on_screen:
		if is_instance_valid(c):
			c.queue_free()
	current_card_on_screen.clear()
	selector_ui.visible = false

func reset_storage():
	card_storage += blacklist	
	

func clear_card_from_screen():
	for c in current_card_on_screen:
		if is_instance_valid(c): c.queue_free()
	current_card_on_screen.clear()

func update_label(name : String, des : String, tag : String):
	card_name.text = name
	card_des.text = des
	card_stat.text = tag
func go_to_zero(delta  :float):
	grid.position  = lerp(grid.position, Vector2(0,0), delta * 200)

func leave(delta: float):
	grid.position = lerp(grid.position, Vector2(0,-360), delta * 200)
