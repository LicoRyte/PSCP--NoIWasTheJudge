extends BulletModifier #Modifier ต้อง extends จาก BulletModifier หมายความว่า จะมีฟังก์ชั่นและตัวแปรของ BulletModifer
 #TIPS : สามารถคลิกขวาที่ Class (ตัวแปรที่มีสีเขียวเช่น Damage, BulletModifier, State) แล้วกด lookup symbol เพื่อเช็ค function ของ class นั้นได้
class_name FlameBullet #ตั้งชื่อ Scripts aka Class


var burn_damage : float =  2
var burn_tick : float = 0.5
var duration : float = 2


func _ready() -> void:
	pass

func on_spawn(bullet: Bullet):
	bullet.extra_damage += 2

func on_hit(bullet, target, bullet_attributes):
	var eff = Effect.new()
	eff.damage = burn_damage
	eff.tick_value = burn_tick
	eff.duration = duration
	eff.inflict(target)
	bullet_attributes["function"].append(
		Callable(Damage, "deal_effect").bind(eff , target)
	)
	return bullet_attributes
