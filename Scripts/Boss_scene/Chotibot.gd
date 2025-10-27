extends Entity
class_name Chotibot
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum BossStage {  
	IDLE,
	BULLET,
	BEAM,
	STATIC,
	DEFEATED
}
var current_state = BossStage.BEAM

var attack_scene = {
	"BEAM" : preload("res://Scene/Boss_scene/beam.tscn"),
	"PSCP" : preload("res://Scene/Boss_scene/pscp.tscn"),
	"STATIC" : preload("res://Scene/Boss_scene/static.tscn"),
}


var current_bullet_time = 0.0
var current_stage_time = 0.0

var beam_cooldown = 0.6
var max_beam_count = 4
var current_beam = 0
var current_beam_timer = 0.0

var static_cooldown = 1.4
var max_static_count = 5
var current_static = 0
var current_static_timer = 0.0

var PSCP_cooldown = 0.45
var max_PSCP_count = 7
var current_PSCP = 0
var current_PSCP_timer = 0.0

var destroyed_effect_cooldown = 0.17
var current_time = 0.0

func _ready() -> void:
	animation_player.play("Idle")
	connect("_object_died", defeated)
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("DevTest"):
		to(BossStage.BEAM)
	

	match current_state:
		
		BossStage.BEAM:
			current_beam_timer += delta
			if current_beam_timer > beam_cooldown:
				current_beam += 1
				var attack = attack_scene["BEAM"].instantiate()
				add_child(attack)
				attack.global_position = Vector2(0, randf_range(0,360))
				current_beam_timer = 0.0
			if current_beam >= max_beam_count:
				current_beam = 0
				current_beam_timer = 0.0
				to(BossStage.STATIC)
		BossStage.STATIC:
			current_static_timer += delta
			if current_static_timer > static_cooldown:
				current_static += 1
				var attack = attack_scene["STATIC"].instantiate()
				add_child(attack)
				attack.global_position = Vector2(0, 0)
				current_static_timer = 0.0
			if current_static >= max_static_count:
				current_static = 0
				current_static_timer = 0.0
				to(BossStage.BULLET)
		BossStage.BULLET:
			current_PSCP_timer += delta
			if current_PSCP_timer > PSCP_cooldown:
				current_PSCP += 1
				var attack = attack_scene["PSCP"].instantiate()
				add_child(attack)
				attack.global_position = Vector2(0, randf_range(0,360))
				current_PSCP_timer = 0.0
			if current_PSCP >= max_PSCP_count:
				current_PSCP = 0
				current_PSCP_timer = 0.0
				to(BossStage.BEAM)
		BossStage.DEFEATED:
			current_time += delta
			if current_time > destroyed_effect_cooldown:
				CamCom.play_effect("fracture", global_position)
				GlobalAudio.fx("boss_defeated")
				current_time = 0.0
				GameEvents._shake_call.emit()

func to(new_state : BossStage):
	current_state = new_state

func defeated():
	to(BossStage.DEFEATED)
