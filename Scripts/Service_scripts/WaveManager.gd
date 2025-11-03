extends Node

var current_wave: int = 0
var current_enemy: int = 0

var task_running: bool = false
var spawn_done: bool = false

enum Sequence { WAIT_FOR_START, WAIT, SPAWN, CARD_CHOOSING }
var cur_seq: int = Sequence.WAIT_FOR_START

signal new_wave(int)


func _ready() -> void:
	GameEvents._game_start.connect(_on_game_start)
	GameEvents._game_continue.connect(_on_game_continue)

func _process(_delta: float) -> void:
	match cur_seq:
		Sequence.WAIT_FOR_START:
			pass
		Sequence.WAIT:
			_run_task(_state_wait)

		Sequence.SPAWN:
			_run_task(_state_spawn)

		Sequence.CARD_CHOOSING:
			GameEvents._reward_sequence.emit()
			GlobalAudio.change_music("intermission")
			current_wave += 1
			spawn_done = false
			cur_seq = Sequence.WAIT_FOR_START

func _run_task(fn: Callable) -> void:
	if task_running:
		return
	task_running = true
	fn.call()

# --- STATES COROUTINES -------------------

func _state_wait() -> void:
	new_wave.emit(current_wave)
	await get_tree().create_timer(3.0).timeout
	cur_seq = Sequence.SPAWN
	task_running = false

func _state_spawn() -> void:
	if not spawn_done:
		spawn_done = true
		if current_wave > 0 and current_wave % 3 == 0:
			GlobalAudio.change_music("boss")
			current_enemy = 1
			var boss: Node2D = _spawn_boss(0, 180)
		else:
			GlobalAudio.change_music("normal")
			current_enemy = _get_enemy_count(current_wave)
			var count = current_enemy
			for i in count:
				var e: Enemy = _spawn_enemy(randf_range(0, 640), randf_range(0, 360))
				await get_tree().create_timer(0.15).timeout

	if current_enemy <= 0:
		cur_seq = Sequence.CARD_CHOOSING
	task_running = false











#--------- HELPER

func _spawn_enemy(x: float, y: float) -> Node2D:
	var new_enemy: Node2D = SceneManager.create_enemy(Vector2(x, y))
	get_tree().current_scene.add_child(new_enemy)

	new_enemy.add_to_group("enemies")
	new_enemy.defeated.connect(_on_enemy_defeated)

	return new_enemy

func _spawn_boss(x: float, y: float) -> Node2D:
	var new_boss : Node2D = SceneManager.create_boss(Vector2(x,y))
	get_tree().current_scene.add_child(new_boss)
	new_boss.add_to_group("enemies")
	new_boss.boss_defeated.connect(_on_enemy_defeated)
	return new_boss

func _on_enemy_defeated() -> void:
	GameEvents.update_enemy_killed.emit()
	current_enemy -= 1
	print("ENEMIES LEFT : ", current_enemy)
	if current_enemy <= 0 and cur_seq == Sequence.SPAWN:
		cur_seq = Sequence.CARD_CHOOSING


func _get_enemy_count(wave: int) -> int:
	return 12 + int(floor(wave / 0.5))

func get_wave_health_multiplier() -> float:
	return max(1.0, 1.0 + 0.25 * float(floor(current_wave / 1.75)))

func get_wave_damage_multiplier() -> float:
	return max(1.0, 1.0 + 0.25 * float(floor(current_wave / 1.75)))

func _on_game_start() -> void:
	print("start")
	cur_seq = Sequence.WAIT

func _on_game_continue() -> void:
	print("continue")
	cur_seq = Sequence.WAIT
