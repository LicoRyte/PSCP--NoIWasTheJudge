extends Entity
class_name Enemy

@onready var player = get_node("/root/guide_test_pc/Player")
@export var health:float = 100.0
var player_chase = false

func _ready() -> void:
	super._ready()
	_entity_died.connect(_enemy_is_died)
	Damage._deal_damage.connect(_on_deal_damage)

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	if player_chase:
		velocity = direction * 100
		move_and_slide()

func _on_detection_area_body_entered(_body: Node2D) -> void:
	player_chase = true

func _on_detection_area_body_exited(_body: Node2D) -> void:
	player_chase = false

func _enemy_is_died():
	queue_free()
	
func _on_deal_damage(amount: float, receiver: Node2D, _source: Node) -> void:
	if receiver == self:
		CamCom.play_effect("fracture", receiver.global_position)
