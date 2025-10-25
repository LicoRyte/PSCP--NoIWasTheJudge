extends Entity
class_name Player

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var card_container: Node = $CardContainer
@onready var player_cam: Camera2D = $Camera2D

"""dash component"""
@export var dash_speed: float = 750.0
@export var dash_duration: float = 0.18
@export var dash_cooldown: float = 0.35

"""player component"""
@export var max_stamina: float = 100.0
@export var move_speed: float = 200

var last_input_direction := Vector2(0,0)
var is_dashing: bool = false
var can_dash: bool = true
var _dash_cd_left: float = 0.0
var current_stamina: float
var current_move_speed: float
var gun : Gun
var anims : AnimatedSprite2D

func _ready() -> void:
	super._ready()
	GameEvents._shake_call.connect(camera_shake)
	gun = get_node_or_null("AnimatedSprite2D/gun")
	current_stamina = max_stamina
	
	_entity_died.connect(_on_player_died)
	
	state_machine_mm.initialize(self)
	GameEvents._hpchanged.emit(current_health)
	
func _process(delta: float) -> void:
	GameEvents._hpchanged.emit(current_health)
	super._process(delta)
	current_move_speed = move_speed * current_speed_multiplier
	
	"""นับเวลา dash cooldown"""
	if not can_dash:
		_dash_cd_left -= delta
		if _dash_cd_left <= 0.0:
			_dash_cd_left = 0.0
			can_dash = true
			

func _physics_process(delta: float) -> void:
	state_machine_mm.process_physics(delta)
func _unhandled_input(event: InputEvent) -> void:
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

func recieve_damage(amount: float, target: Entity, source : Node = null) -> void:
	super(amount, target, source)
	CamCom.play_effect("fracture", target.global_position)
	camera_shake()
	GlobalAudio.fx("damage")
