extends Entity
class_name Player

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var state_machine_at: StateMachine = $StateMachine_AT


signal _player_died


var anims : AnimatedSprite2D

@export var max_health: float = 100.0
var current_health: float
@export var max_stamina: float = 100.0
var current_stamina: float

#----Status
var is_died: bool = false

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

func _unhandled_input(event: InputEvent) -> void:
	state_machine_mm.process_events(event)
	state_machine_mm.process_events(event)




"""Health And Stamina Function"""
func recieve_damage(amount: float, target: Node2D, source : Node = null) -> void:
	if target == self:
		current_health -= amount
		#print(current_health)
	current_health = clamp(current_health, 0, max_health)
	if current_health <= 0:
		_player_died.emit()

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
	
