extends Resource
class_name Effect



var damage : float
var effect_name : String
var tick_value: float
var duration: float = 0.0
var defense_decreased : float = 0.0
var defense_increased : float = 0.0
var speed_decreased : float = 0.0
var speed_increased: float = 0.0

var entity: Node2D = null
var stat : StatComponent = null
var health : HealthComponent = null

var timer : float = 0.0
var time_left : float = 0.0

var att = Attack.new()
var is_active : bool = false

func inflict(target: Node2D, override_duration: float = 0.0):
	entity = target
	health = Common.get_component(entity, HealthComponent)
	stat = Common.get_component(entity, StatComponent)
	att.damage = damage
	
	if not is_active:
		is_active = true
	timer = 0.0
	if override_duration:
		time_left = override_duration
	else:
		time_left = duration

func refresh(extended_time: float):
	time_left = max(time_left, 0.0) + extended_time
	time_left = clamp(time_left, -1.0, duration)

func effect_update(delta :float) -> bool:
	self.duration -= delta
	self.timer += delta
	var ticked: bool = false
	if self.timer >= self.tick_value:
		self.timer -= self.tick_value
		_on_ticked()
		tick_value = true
	if self.duration < 0:
		stop()
	return tick_value

func stop():
	entity = null
	health = null
	stat = null
	timer = 0.0
	time_left = 0.0

func _on_ticked():
	if health:
		health.receive_damage(att, true)

func is_expired():
	return not is_active

"""STAT GETTER"""
func get_defense_value():
	return speed_increased - speed_decreased

func get_speed_value():
	return speed_increased - speed_decreased
