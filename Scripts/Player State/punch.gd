extends State

@export var shoot_state : State
@export var unarm_state: State



func enter():
	pass
func exit():
	pass
func process_physics(delta: float) -> State:
	return null
func process_input(event: InputEvent) -> State:
	return null
