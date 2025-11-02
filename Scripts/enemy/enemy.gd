extends Entity
class_name Enemy

@export var health:float = 100.0
var player_chase = false
var player : Player

var died : bool

signal defeated
@onready var stat_component: StatComponent = $StatComponent


func _ready() -> void:
	player = get_tree().current_scene.get_node_or_null("Player")
	connect("_object_died",_enemy_is_died)
	_entity_died.connect(_enemy_is_died)

func _physics_process(_delta: float) -> void:
	if player:
		if player_chase:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * (stat_component.base_speed * stat_component.speed_multiplier)
			move_and_slide()
		else:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * 100
			move_and_slide()

func _on_detection_area_body_entered(_body: Node2D) -> void:
	player_chase = true

func _on_detection_area_body_exited(_body: Node2D) -> void:
	player_chase = false

func _enemy_is_died():
	if not died:
		defeated.emit()
		queue_free()
		GameEvents.enemy_killed += 1
		died = true	
	
func _on_deal_damage(amount: float, receiver: Node2D, _source: Node) -> void:
	if receiver == self:
		CamCom.play_effect("fracture", receiver.global_position)

func _on_hitbox_body_entered(body: Node2D) -> void:
	return
