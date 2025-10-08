extends Entity
class_name Player

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var state_machine_at: StateMachine = $StateMachine_AT




var anims : AnimatedSprite2D


@export var max_stamina: float = 100.0
@export var move_speed: float = 200
var current_stamina: float
var current_move_speed: float


var cardcontainer := Array()

func _ready() -> void:
	super._ready()
	current_stamina = max_stamina
	_player_died.connect(_on_player_died)
	state_machine_mm.initialize(self)
	state_machine_at.initialize(self)

func _process(delta: float) -> void:
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
	
