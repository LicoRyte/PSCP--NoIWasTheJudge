extends State

@export var run_state : State
@export var jump_state: State
@export var killed_state: State
@export var stunned_state: State

var move_speed = 10
var acceleration = 60
func enter():
	pass
func exit():
	pass
func process_physics(delta: float) -> State:
	if Input.is_action_just_pressed("Space"):
		return jump_state
	if player.is_died:
		return killed_state
		
	#player.velocity.x = lerp(player.velocity.x , 40, delta)
	player.move_and_slide()
	return null
func process_input(event: InputEvent) -> State:
	return null
