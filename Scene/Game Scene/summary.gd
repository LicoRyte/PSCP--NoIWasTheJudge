extends Control
@onready var vbox: VBoxContainer = $CanvasLayer/MarginContainer/VBoxContainer



# Labels
@onready var summary_label: Label      = $CanvasLayer/MarginContainer/VBoxContainer/sum
@onready var enemy_killed_label: Label = $CanvasLayer/MarginContainer/VBoxContainer/killed
@onready var collected_label: Label    = $CanvasLayer/MarginContainer/VBoxContainer/collected
@onready var space_label: Label        = $CanvasLayer/MarginContainer/VBoxContainer/space

var enemy_defeated: int = 0
var card_collected: int = 0

var can_exit: bool = false
var reveal_task_running: bool = false


func _ready() -> void:
	GameEvents.update_card_collected.connect(_on_card_collected)
	GameEvents.update_enemy_killed.connect(_on_enemy_killed)

	_set_all_visible(false)
	_start_reveal_flow()


func _process(_delta: float) -> void:
	if can_exit and Input.is_action_just_pressed("Space"):
		_exit_summary()

func _start_reveal_flow() -> void:
	if reveal_task_running:
		return
	reveal_task_running = true
	_reveal_flow()


func _reveal_flow() -> void:
	await get_tree().create_timer(2.0).timeout
	_refresh_numbers()

	for child in vbox.get_children():
		child.visible = true
		await get_tree().create_timer(1.0).timeout

	can_exit = true
	reveal_task_running = false

func _exit_summary() -> void:
	can_exit = false
	_set_all_visible(false)
	SceneManager.change_scene("main_menu")
	queue_free()

func _set_all_visible(val: bool) -> void:
	for child in vbox.get_children():
		if child is Control:
			child.visible = val


func _refresh_numbers() -> void:
	summary_label.text = "--- SUMMARY ---"
	enemy_killed_label.text = "Enemy Defeated : " + str(enemy_defeated)
	collected_label.text = "Card Collected : " + str(card_collected)
	space_label.text = "Press SPACE to continue"

func _on_enemy_killed() -> void:
	enemy_defeated += 1

func _on_card_collected() -> void:
	card_collected += 1
