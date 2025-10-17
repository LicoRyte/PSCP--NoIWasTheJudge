extends Boss
class_name Chotibot

enum BossStage {  
	IDLE,      
	BULLET,  
	SPAWN  
}

var attack_scene = {
	"BEAM" : preload("res://Scripts/Boss/beam.tscn"),
	"PSCP" : preload("res://Scripts/Boss/pscp.tscn"),
	"STATIC" : preload("res://Scripts/Boss/static.tscn")
}

@export var bullet_stage_time = 5
@export var spawn_stage_time = 5

var current_bullet_time = 0.0
var current_stage_time = 0.0

@export var current_state : BossStage = BossStage.IDLE

func while_alive(delta: float):
	match current_state:
		BossStage.IDLE:
			pass
		BossStage.BULLET:
			current_bullet_time += delta
			pass
		BossStage.SPAWN:
			current_stage_time += delta
			pass


func change_state(new_state : BossStage):
	if new_state == current_state:
		return
	current_state = new_state
	
