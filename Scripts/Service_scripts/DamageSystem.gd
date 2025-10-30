extends Node
class_name DamageSystem

func deal_damage(damage : float, body: Node2D , crit_rate: float = 0, crit_mul : float = 0):
	var hitbox = Common.get_component(body, HitboxComponent)
	if not hitbox:
		return
	var att_pack = Attack.new()
	att_pack.damage = damage
	att_pack.crit_chance = crit_rate
	att_pack.crit_multiplier = crit_mul
	att_pack.roll()
	if hitbox.has_method("detect_attack"):
		hitbox.detect_attack(att_pack)

func deal_effect(effect : Effect, body: Node2D): #Enemy  
	var detect_area = Common.get_component(body, HitboxComponent)
	if not detect_area:
		return
	if detect_area.has_method("detect_effect"):
		detect_area.detect_effect(effect) 
