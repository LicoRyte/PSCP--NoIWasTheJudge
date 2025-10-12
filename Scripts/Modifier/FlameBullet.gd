extends BulletModifier #Modifier ต้อง extends จาก BulletModifier หมายความว่า จะมีฟังก์ชั่นและตัวแปรของ BulletModifer
 #TIPS : สามารถคลิกขวาที่ Class (ตัวแปรที่มีสีเขียวเช่น Damage, BulletModifier, State) แล้วกด lookup symbol เพื่อเช็ค function ของ class นั้นได้
class_name FlameBullet #ตั้งชื่อ Scripts aka Class


var burn_damage : float =  3
var burn_tick : float = 0.35
var duration : float = 5


func _ready() -> void:
	pass

func on_spawn(bullet: Bullet):
	bullet.extra_damage += 2

func on_hit(bullet, target, bullet_attributes):
	#Append function เข้าไปใน Array ใน bullet.gd
	bullet_attributes["function"].append(
		Damage.inflict_flame(burn_damage, duration, burn_tick, target)
	)
