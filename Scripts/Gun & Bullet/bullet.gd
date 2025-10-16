extends Node2D
class_name Bullet




var modifier :Array[BulletModifier] = [
	#ReverseBullet.new()
] #เก็บ Scripts ตัวลูกของ BulletModifer
@export var base_damage = 5 #ดาเมจพื้นฐาน
@export var bullet_duration = 5 #รอ 5 วิจนกว่าจะหายไป

#----Common Attributes เก็บค่าสถานะพื้นฐานของทุกๆ กระสุน
var can_destroy = false        #หากเป็นจริงให้ลบได้
var base_bullet_speed : int = 300 #ปรับความเร็วของกระสุน หากติดลบจะไปทิศตรงกันข้าม
var extra_damage = 0

func _ready() -> void:
	for i in GameEvents.current_mod:
		add_mod(i)
	

func _process(delta: float) -> void:
	position += transform.x * base_bullet_speed * delta
	for mod in modifier:
		mod.on_active(self, delta)
	bullet_duration -= delta
	
	if bullet_duration <= 0 or can_destroy:
		queue_free()

func apply_hit(target: Entity):
	var bullet_attributes = {
		"damage" : base_damage,
		"bulletSpeed" : base_bullet_speed,
		"canDestroy" : can_destroy,
		"bulletDuration" : bullet_duration,
		"function" : [
			#Damage.inflict_flame()
		] #สำหรับเรียกใช้ function """function เป็นชนิดข้อมูลรูปแบบหนึ่งคือ Callable  สามารถเก็บเข้า Array เหมือนข้อมูลปกติได้
	}
	#วิธีการคือเราจะ Append function ของ Modifier เข้าไปใน values ของ key function
	for mod in modifier:
		bullet_attributes = mod.on_hit(self, target, bullet_attributes) # นำ Bullet Attribute บวก effect จาก Modifier แต่ละตัว
		
	Damage.deal_damage(base_damage + extra_damage, target)
	
	#แล้วจึง loop เข้าไปใช้ function แต่ละตัว
	for fn in bullet_attributes["function"]:
		fn.call()
# delete bullet ที่ออกขอบจอ
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func new_mod_added(mod : BulletModifier):
	add_mod(mod)

func add_mod(mod : BulletModifier):
	if mod not in modifier:
		modifier.append(mod)
		mod.on_spawn(self)
	
func remove_mod(mod: BulletModifier):
	modifier.erase(mod)
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		GameEvents._bullet_hit_enemies.emit()
		GlobalAudio.fx("damage")
		apply_hit(body)
		queue_free()
