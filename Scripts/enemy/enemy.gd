extends Entity
class_name Enemy

@onready var player = get_node("/root/guide_test_pc/Player")
@export var health:float = 100.0
var player_chase = false

func _ready() -> void:
	Damage._deal_damage.connect(_on_deal_damage)

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	if player_chase:
		velocity = direction * 100
		move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player_chase = false









func _enemy_is_died():
	queue_free()
	
func _on_deal_damage(amount: float, receiver: Node2D, source: Node) -> void:
	if receiver == self:
		health -= amount
		print_debug(health)
		if health <= 0:
			_enemy_is_died()
