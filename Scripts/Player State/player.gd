extends CharacterBody2D
class_name Player

@onready var state_machine_mm: StateMachine = $StateMachine_MM
@onready var state_machine_at: StateMachine = $StateMachine_AT
@onready var stamina: Node = $Stamina
@onready var health: Node = $Health


var anims : AnimatedSprite2D

var current_health: float
var current_stamina: float

func _ready() -> void:
	current_health = health.current_health
	current_stamina = stamina.current_stamina
	state_machine_mm.initialize(self)
	state_machine_at.initialize(self)


func _physics_process(delta: float) -> void:
	state_machine_mm.process_physics(delta)
	state_machine_at.process_physics(delta)
func _unhandled_input(event: InputEvent) -> void:
	state_machine_mm.process_events(event)
	state_machine_mm.process_events(event)
