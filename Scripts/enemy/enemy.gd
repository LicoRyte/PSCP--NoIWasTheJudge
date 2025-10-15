extends Entity
class_name Enemy

var speed_enemy = 1
var player = null
var player_chase = false
@export var health:float = 100.0

func _ready() -> void:
	Damage._deal_damage.connect(_on_deal_damage)

func _enemy_is_died():
	queue_free()

func _physics_process(delta: float) -> void:
	if player_chase:
		position += ((player.position - position) / speed_enemy) * delta

func _on_detection_area_body_entered(body: Node2D) -> void:
		player = body
		player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

func _on_deal_damage(amount: float, receiver: Node2D, source: Node) -> void:
	if receiver == self:
		health -= amount
		print_debug(health)
		if health <= 0:
			_enemy_is_died()
