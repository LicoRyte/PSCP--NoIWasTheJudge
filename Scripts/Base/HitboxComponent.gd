extends CollisionShape2D
class_name HitboxComponent

var is_immune : bool

@export var health_component : HealthComponent
@export var status_component : StatusComponent

func _ready() -> void:
	health_component = Common.get_component(Common.find_real_parent(self, CharacterBody2D), HealthComponent)
	status_component = Common.get_component(Common.find_real_parent(self, CharacterBody2D), StatusComponent)

func detect_attack(attack: Attack):
	if is_immune or not health_component:
		return
	health_component.receive_damage(attack)
	CamCom.play_effect("fracture", global_position)

func detect_effect(effect: Effect): 
	if is_immune or not status_component:
		return
	status_component.addEffect(effect)


func set_immune(active: bool):
	is_immune = active
