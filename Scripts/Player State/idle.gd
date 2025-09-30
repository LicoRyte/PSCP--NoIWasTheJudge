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
	var input_direction = Vector2(
		Input.get_action_strength("Left") - Input.get_action_strength("Right"),
		Input.get_action_strength("Up") - Input.get_action_strength("Down")
	)
	player.velocity = lerp(player.velocity, input_direction * move_speed, delta * acceleration)
	player.move_and_slide()


	return null
func process_input(event: InputEvent) -> State:
	return null
