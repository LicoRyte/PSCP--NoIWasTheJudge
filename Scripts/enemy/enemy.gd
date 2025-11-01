extends Entity
class_name Enemy

var player : Player = null #get_node("/root/guide_test_pc/Player")
@export var health:float = 100.0
var player_chase = false
var died : bool = false

signal defeated

func _ready() -> void:
	connect("_object_died",_enemy_is_died)
	_entity_died.connect(_enemy_is_died)

func _physics_process(_delta: float) -> void:
	if player:
		var direction = global_position.direction_to(player.global_position)
		if player_chase:
			velocity = direction * 100
			move_and_slide()

func _on_detection_area_body_entered(_body: Node2D) -> void:
	if _body is Player:
		player = _body
		player_chase = true

func _on_detection_area_body_exited(_body: Node2D) -> void:
	if _body is Player:
		player = _body
		player_chase = false

func _enemy_is_died():
	if not died:
		defeated.emit()
		queue_free()
		died = true	
	
func _on_deal_damage(amount: float, receiver: Node2D, _source: Node) -> void:
	if receiver == self:
		CamCom.play_effect("fracture", receiver.global_position)
