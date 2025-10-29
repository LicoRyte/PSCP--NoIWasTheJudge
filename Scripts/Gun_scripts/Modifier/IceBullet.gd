extends BulletModifier 
class_name IceBullet

var ice_damage : float =  1
var ice_tick : float = 0.3
var duration : float = 3
var speed : float = 100

func _ready() -> void:
	pass

func on_spawn(bullet: Bullet):
	pass

func on_hit(bullet, target, bullet_attributes):
	var eff = Effect.new()
	eff.damage = ice_damage
	eff.tick_value = ice_tick
	eff.duration = duration
	eff.speed_decreased = speed
	eff.inflict(target)
	bullet_attributes["function"].append(
		Callable(Damage, "deal_effect").bind(eff , target)
	)
	return bullet_attributes
