extends BulletModifier #Modifier ต้อง extends จาก BulletModifier หมายความว่า จะมีฟังก์ชั่นและตัวแปรของ BulletModifer
 #TIPS : สามารถคลิกขวาที่ Class (ตัวแปรที่มีสีเขียวเช่น Damage, BulletModifier, State) แล้วกด lookup symbol เพื่อเช็ค function ของ class นั้นได้
class_name ReverseBullet #ตั้งชื่อ Scripts aka Class


var time_till_reverse : float = 2
var reverse_speed : float

func _ready() -> void:
	pass

func on_spawn(bullet: Bullet):
	reverse_speed = bullet.base_bullet_speed / time_till_reverse
	bullet.extra_damage += 4

func on_active(bullet : Bullet, delta):
	bullet.base_bullet_speed -= reverse_speed * delta  * 3
	bullet.base_bullet_speed = clamp(bullet.base_bullet_speed, -1000, bullet.base_bullet_speed)
	
