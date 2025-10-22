extends Node
class_name BulletModifier

#เมื่อถูกเสกขึ้นมา
func on_spawn(bullet):
	pass

#ระหว่างที่กำลังทำงานอยู่ใน Runtime
func on_active(bullet, delta):
	pass

#เมื่อชนกับสิ่งที่ชนได้
func on_hit(bullet, target, effect):
	return effect
