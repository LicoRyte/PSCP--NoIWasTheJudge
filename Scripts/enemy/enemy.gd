extends Entity

var speed_enemy = 1
var player = null
var player_chase = false

func _physics_process(delta: float) -> void:
	if player_chase:
		position += ((player.position - position) / speed_enemy) * delta

func _on_detection_area_body_entered(body: Node2D) -> void:
		player = body
		player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
