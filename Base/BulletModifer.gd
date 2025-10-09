extends Node
class_name AttackModifier


func on_spawn(bullet):
	pass

func on_travel(bullet, delta):
	pass

func on_hit(bullet, reciever, effect_context):
	return effect_context
