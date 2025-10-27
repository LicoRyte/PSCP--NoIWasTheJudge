extends TextureProgressBar

@export var health_component: HealthComponent


func _ready():
	if health_component:
		health_component.health_changed.connect(update_bar)
		update_bar(health_component._get_health(), health_component._get_max_health())
	
func update_bar(current_health: float, max_health: float):
	value = current_health
	max_value = max_health

func _process(delta: float) -> void:
	update_bar(GameEvents.get_health()._get_health(),GameEvents.get_health()._get_max_health())
