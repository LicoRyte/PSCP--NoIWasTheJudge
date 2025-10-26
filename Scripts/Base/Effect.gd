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


#5 "Flame" 0.35 2 2
func inflict(target: Node2D, override_duration: float = 0.0): 
	entity = target #Enemy #5 "Flame" 0.35 2 2
	health = Common.get_component(entity, HealthComponent)
	stat = Common.get_component(entity, StatComponent)
	att.damage = damage #5
	
	if not is_active:
		is_active = true
	timer = 0.0
	if override_duration:
		time_left = override_duration
	else:
		time_left = duration #0 -> 2

func refresh(extended_time: float):
	time_left = max(time_left, 0.0) + extended_time
	time_left = clamp(time_left, -1.0, duration)
	return time_left

func effect_update(delta :float) -> bool:
	self.duration -= delta #5 "Flame" 0.35 2 2 #Enemy
	self.timer += delta
	
	var ticked: bool = false
	
	if self.timer >= self.tick_value:
		self.timer -= self.tick_value
		_on_ticked()
		ticked = true
	if self.duration < 0:
		stop()
	
	return ticked

func stop():
	is_active = false
	entity = null
	health = null
	stat = null
	timer = 0.0
	time_left = 0.0

func _on_ticked():
	if health: #Enemy has health_com
		health.receive_damage(att, true)

func is_expired():
	return not is_active

"""STAT GETTER"""
func get_defense_value():
	return defense_increased - defense_decreased

func get_speed_value():
	return speed_increased - speed_decreased
