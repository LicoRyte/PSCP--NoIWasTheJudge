extends Entity
class_name Player

signal stamina_changed(value)

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
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
	GameEvents._shake_call.connect(camera_shake)
	gun = get_node_or_null("AnimatedSprite2D/gun")
	current_stamina = max_stamina
	_entity_died.connect(_on_player_died)
	state_machine_mm.initialize(self)

func _process(delta: float) -> void:
	current_move_speed = move_speed
	"""นับเวลา dash cooldown"""
	if not can_dash:
		_dash_cd_left -= delta
		if _dash_cd_left <= 0.0:
			_dash_cd_left = 0.0
			can_dash = true
	"""regen stamina"""
	if  current_stamina < max_stamina:
		change_stamina(10 * delta)
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
	emit_signal("stamina_changed", current_stamina)


"""Signal-Based Function"""
func _on_player_died():
	GameEvents._player_died.emit()
	is_died = true

func camera_shake():
	CamCom.apply_shake(player_cam,3,5)

func recieve_damage(amount: float, target: Entity, source : Node = null) -> void:
	camera_shake()
	GlobalAudio.fx("damage")
