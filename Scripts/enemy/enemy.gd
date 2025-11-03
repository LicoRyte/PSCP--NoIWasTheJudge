extends Entity
class_name Enemy

@export var health:float = 100.0
@export var enemy_bullet_scene = preload("res://Scene/enemy/enemy_bullet.tscn")
var player_chase := true
var can_shoot := true
var player : Player

var died : bool

signal defeated
@onready var stat_component: StatComponent = $StatComponent


func _ready() -> void:
	player = get_tree().current_scene.get_node_or_null("Player")
	connect("_object_died",_enemy_is_died)
	_entity_died.connect(_enemy_is_died)

func _physics_process(_delta: float) -> void:
	print(player_chase)
	if player_chase:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 50
		move_and_slide()
		can_shoot = true

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_chase = false

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_chase = true

func _enemy_is_died():
	if not died:
		defeated.emit()
		queue_free()
		GameEvents.enemy_killed += 1
		died = true
	
func _on_deal_damage(amount: float, receiver: Node2D, _source: Node) -> void:
	if receiver == self:
		CamCom.play_effect("fracture", receiver.global_position)

func shoot_bullet():
	var new_enemy_bullet = enemy_bullet_scene.instantiate()
	new_enemy_bullet.global_position = global_position
	var dir := (player.global_position - global_position).normalized()
	new_enemy_bullet.velocity = dir * new_enemy_bullet.speed
	get_tree().current_scene.add_child(new_enemy_bullet)
	
func _on_timer_timeout() -> void:
	if can_shoot:
		shoot_bullet()
