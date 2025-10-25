extends Resource
class_name Effect



var damage : float
var effect_name : String
var tick_value: float
var timer : float = 0.0
var duration: float = 0.0

var defense_decreased : float
var defense_increased : float

var speed_decreased : float
var speed_increased: float



func effect_update(delta :float):
	self.duration -= delta
	self.timer += delta
	if self.timer >= self.tick_value:
		self.timer -= self.tick_value
		return true
	return false

func is_expired():
	return self.duration <= 0
