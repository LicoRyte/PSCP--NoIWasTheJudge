extends Boss
class_name Chotibot

enum BossStage {  
	IDLE,      
	BULLET,  
	SPAWN  
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
	
	match current_state:
		BossStage.BULLET:
			current_bullet_time = 0.0
		BossStage.SPAWN:
			current_stage_time = 0.0
	current_state = new_state
	
