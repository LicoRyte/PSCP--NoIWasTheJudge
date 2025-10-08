extends Node

"""ระบบ damage"""
"""วิธีการเรียกใช้คือ Damage.deal_damage(ดาเมจ, object ที่ต้องการทำดาเมจใส่)"""
"""สิ่งที่ต้องการจะให้รับดาเมจได้ ควรจะมี Damage._deal_damage.connect(ฟังก์ชั่นรับดามจ) กำกับไว้ที่ ready() ด้วย  (ดูตัอย่างจาก Player)"""

signal _deal_damage(amount: float, reciever: Node2D, source: Node)
signal _do_stun(duration: float, reciever: Node2D)
func deal_damage(amount: float, reciever: Node2D, source: Node= null):
	_deal_damage.emit(amount, reciever, source)

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
