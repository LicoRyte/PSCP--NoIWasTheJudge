extends Entity
class_name Player

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var state_machine_at: StateMachine = $StateMachine_AT
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var card_container: Node = $CardContainer
@onready var player_cam: Camera2D = $Camera2D


var gun : Gun

var anims : AnimatedSprite2D


@export var max_stamina: float = 100.0
@export var move_speed: float = 200
var current_stamina: float
var current_move_speed: float

func _ready() -> void:
	super._ready()
	GameEvents._shake_call.connect(camera_shake)
	gun = get_node_or_null("AnimatedSprite2D/gun")
	current_stamina = max_stamina
	_entity_died.connect(_on_player_died)
	GameEvents._card_append.connect(add_card_to_card_container)
	state_machine_mm.initialize(self)
	state_machine_at.initialize(self)
	GameEvents._hpchanged.emit(current_health)
	
func _process(delta: float) -> void:
	GameEvents._hpchanged.emit(current_health)
	#print_debug(GameEvents.current_mod)
	super._process(delta)
	current_move_speed = move_speed * current_speed_multiplier
func _physics_process(delta: float) -> void:
	state_machine_mm.process_physics(delta)
	state_machine_at.process_physics(delta)
func _unhandled_input(event: InputEvent) -> void:
	state_machine_mm.process_events(event)
	state_machine_mm.process_events(event)




"""Health And Stamina Function"""

func stamina_request(amount: float) -> bool:
	if current_stamina <= 0 or amount > current_stamina:
		return false
	else:
		return true

func change_stamina(amount: float):
	current_stamina += amount
	current_stamina = clamp(current_stamina, 0, max_stamina)



"""Signal-Based Function"""
func _on_player_died():
	GameEvents._player_died.emit()
	is_died = true

func _on_card_container_child_entered_tree(card: Card) -> void:
	print_debug(card)
	card.player_stat_change(self)
	card.card_added()
	card.gun_stat_change(gun)

func _on_card_container_child_exiting_tree(card: Card) -> void:
	card.player_stat_revert(self)
	#card.card_removed()

func add_card_to_card_container(card: Card):
	print("Should")
	print(card)
	card_container.add_child(card)

func camera_shake():
	CamCom.apply_shake(player_cam,3,5)
