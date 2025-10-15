extends Node2D

@export var spawn_area = Rect2(Vector2(-300, -200), Vector2(600, 400))

func spawn_mob():
	var random_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x), 
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y))

	var _new_mob = preload("res://Scene/enemy/enemy.tscn").instantiate()
	_new_mob.position = random_position
	add_child(_new_mob)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn_mob"):
		spawn_mob()
