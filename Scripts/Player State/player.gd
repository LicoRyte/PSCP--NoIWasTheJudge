extends CharacterBody2D
class_name Player

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var state_machine_at: StateMachine = $StateMachine_AT
@onready var stamina: Node = $Stamina
@onready var health: Node = $Health



var anims : AnimatedSprite2D

var current_health: float
var current_stamina: float
var is_died: bool = false

func _ready() -> void:
	Damage._deal_damage.connect(recieve_damage)
	#Damage._do_stun.connect()
	health._player_died.connect(_on_player_died)
	
	current_health = health.current_health
	current_stamina = stamina.current_stamina
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
	if target == self and get_node_or_null("Health"):
		health.change_health(amount)
		GameEvents._hpchanged.emit(health.current_health - amount)

func stamina_request(amount: float) -> bool:
	if get_node_or_null("Stamina"):
		var success = stamina.use_stamina(amount)
		return success
	return false

func _on_player_died():
	GameEvents._player_died.emit()
	is_died = true
	
