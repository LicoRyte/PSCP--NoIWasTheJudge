extends Node

signal _deal_damage(amount: float, reciever: Node2D, source: Node)
signal _do_stun(duration: float, reciever: Node2D)



func deal_damage(amount: float, reciever: Node2D, source: Node= null):
	_deal_damage.emit(amount, reciever, source)

func do_stun(duration: float, reciever: Node2D):
	_do_stun.emit(duration, reciever)
