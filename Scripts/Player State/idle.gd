extends State

@export var run_state : State
@export var jump_state: State
@export var killed_state: State
@export var stunned_state: State

func enter():
	player.animated_sprite_2d.play("Idle")
func exit():
	pass
func process_physics(delta: float) -> State:
	return null

func process_input(event: InputEvent) -> State:
	var input_direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Up") - Input.get_action_strength("Down")
	)
	
	if Input.is_action_just_pressed("Space"):
		return jump_state
	if player.is_died:
		return killed_state
	if input_direction:
		return run_state
	if Input.is_action_just_pressed("Space"):
		return run_state
	return null
