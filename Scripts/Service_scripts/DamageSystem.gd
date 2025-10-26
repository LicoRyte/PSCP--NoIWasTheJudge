extends Node


signal _deal_damage(amount: float, reciever: Node2D, source: Node)
signal _do_stun(duration: float, reciever: Node2D)

func deal_damage(damage : float, detect_area : HitboxComponent, crit_rate: float = 0, crit_mul : float = 0):
	var att_pack = Attack.new()
	att_pack.damage = damage
	att_pack.crit_chance = crit_rate
	att_pack.crit_multiplier = crit_mul
	att_pack.roll()
	if detect_area.has_method("detect_attack"):
		detect_area.detect_attack(att_pack)

func deal_effect(effect : Effect, body: Node2D): #Enemy  
	var detect_area = Common.get_component(body, HitboxComponent)
	if not detect_area:
		return
	if detect_area.has_method("detect_effect"):
		detect_area.detect_effect(effect) 


func do_stun(duration: float, reciever: Node2D):
	_do_stun.emit(duration, reciever)

"""Effect System"""
"""Attributes Keyword"""
"""Damage : ดาเมจที่ได้รับ"""
"""Duration : ระยะเวลาของ Effect"""
"""Tick : ความถี่ของ damage ที่ได้รับแต่ละครั้ง เช่นทุกๆ 0.35 วิ"""
"""Move_Speed  : ปรับความเร็ว/ทิศทางของ Entity"""
"""Defense : ปรับ Defense ของ Entity"""
"""Damage_Multiplier : ปรับ Damage_multiplier ของ entity"""

"""REMINDER : EVERY EFFECT ต้องมี Duration else ระเบิด"""

signal _inflict_flame(tag: String, attributes: Dictionary , reciever: Entity)
signal _inflict_poison(tag: String, attributes: Dictionary, reciever: Entity)
signal _inflict_freeze(tag: String, attributes: Dictionary, reciever: Entity)


func inflict_flame(damage: float, duration: float, tick: float, reciever: Entity):
	_inflict_flame.emit("flame", {
		"Damage" : damage,
		"Duration" : duration,
		"Tick" : tick
	}, reciever)

func inflict_poison(damage: float, duration: float, tick: float, defense_reduction: float, reciever: Entity):
	_inflict_poison.emit("poison",{
		"Damage" : damage,
		"Duration" : duration,
		"Tick" : tick,
		"Defense" : defense_reduction
	}, reciever)
	
func inflict_chill(damage: float, move_speed: float, chill_time: float, reciever: Entity):
	_inflict_freeze.emit("chill", {
		"Damage" : damage,
		"Duration" : chill_time,
		"Move_Speed" : move_speed
	}, reciever)
