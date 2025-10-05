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

signal _inflict_flame(effect: String, damage_duration_tick: Array , reciever: Entity)
signal _inflict_poison(effect: String, damage_duration_tick: Array, reciever: Entity)

func inflict_flame(damage: float, duration: float, tick: float, reciever: Entity):
	_inflict_flame.emit("flame", [damage,duration, tick], reciever)

func inflict_poison(damage: float, duration: float, tick: float, reciever: Entity):
	_inflict_poison.emit("poison",[damage,duration,tick], reciever)
