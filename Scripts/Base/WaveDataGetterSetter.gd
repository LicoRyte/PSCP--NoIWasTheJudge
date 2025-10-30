extends Node
class_name WaveDataGetterSetter

var health_component : HealthComponent
var stat_component : StatComponent

func _ready() -> void:
	health_component = Common.get_component(get_parent(), HealthComponent)
	stat_component = Common.get_component(get_parent(), StatComponent)
	health_component._set_max_health(health_component._get_max_health() * Wave.get_wave_health_multiplier())
	health_component._set_current_health(health_component._get_max_health())
