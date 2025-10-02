extends CharacterBody2D
class_name Player

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var state_machine_at: StateMachine = $StateMachine_AT
@onready var stamina: Node = $Stamina
@onready var health: Node = $Health

signal _player_died


var anims : AnimatedSprite2D

@export var max_health: float
var current_health: float
@export var max_stamina: float
var current_stamina: float

#----Status
var is_died: bool = false

var effect := Array()
var cardcontainer := Array()



func _ready() -> void:
	current_health = max_health
	#Damage._do_stun.connect()
	Damage._deal_damage.connect(recieve_damage)
	_player_died.connect(_on_player_died)
	
	state_machine_mm.initialize(self)
	state_machine_at.initialize(self)


func _physics_process(delta: float) -> void:
	state_machine_mm.process_physics(delta)
	state_machine_at.process_physics(delta)
	
	
	current_health = health.current_health
	current_stamina = stamina.current_stamina

func _unhandled_input(event: InputEvent) -> void:
	state_machine_mm.process_events(event)
	state_machine_mm.process_events(event)

#----Component Function

func recieve_damage(amount: float, target: Node2D = self) -> void:
	if target == self:
		current_health -= amount
	current_health = clamp(current_health, 0, max_health)
	if current_health <= 0:
		_player_died.emit()


func stamina_request(amount: float) -> bool:
	if get_node_or_null("Stamina"):
		var success = stamina.use_stamina(amount)
		return success
	return false

func _on_player_died():
	GameEvents._player_died.emit()
	is_died = true
	
