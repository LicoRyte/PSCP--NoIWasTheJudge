extends Node2D
@onready var bullet_label: Label = $text


var custom_text = {
	0 : "INFINITE RECURSION!!!!",
	1 : "YOU AND I LOVE PSCP!!!",
	2 : "JUST SOLVE 125 PROBLEMS",
	3 : "print(\"HELLO WORLD\")",
	4 : "I AM THE REAL JUDGE!!!",
	5 : "GOOD LUCK ON YOUR SCORE",
	6 : "THIS YEAR'S EXAM IS EASY",
	7 : "ZERO STAR IS REALLY EASY",
	8 : "DON\"T FORGET RATATYPE",
	9 : "SORTING TEST THIS FRIDAY",
	10 : "READ THINK PYTHON!",
	11 : "ARE YOU UNDERSTAND?!",
	12 : "PSCP IS IMPORTANT!",
	13 : "DON'T FORGET PAIR PROGRAMMING!"
}
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D
var does_sound = false

@export var base_bullet_speed = 150.0
@export var damage = 15
var time_until_delete  = 15.0

func _ready() -> void:
	GlobalAudio.fx("spear")
	bullet_label.text = custom_text[randi() % custom_text.size()]
	await get_tree().process_frame
	hitbox.shape.size = bullet_label.size
	hitbox.position = Vector2(bullet_label.size.x / 2, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	base_bullet_speed += delta * 200
	base_bullet_speed = clamp(base_bullet_speed,0,300)
	position += transform.x * base_bullet_speed * delta * 1.5
	time_until_delete -= delta
	if time_until_delete <= 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Damage.deal_damage(damage, body)
