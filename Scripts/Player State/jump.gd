extends State


@export var idle_state : State
@export var run_state: State
@export var killed_state: State
@export var stunned_state: State


func enter():
	pass
func exit():
	pass
func process_physics(delta: float) -> State:
	
	player.move_and_slide()
	return null
func process_input(event: InputEvent) -> State:
	return null
