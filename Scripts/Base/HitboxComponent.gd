extends CollisionShape2D
class_name HitboxComponent

var is_immune : bool

@export var health_component : HealthComponent
@export var status_component : StatusComponent

func _ready() -> void:
	health_component = Common.get_component(get_parent(), HealthComponent)
	status_component = Common.get_component(get_parent(), StatusComponent)

func detect_attack(attack: Attack):
	if is_immune or not health_component:
		return
	health_component.receive_damage(attack)

func detect_effect(effect: Effect):
	if is_immune or not status_component:
		return
	status_component.addEffect(effect)
