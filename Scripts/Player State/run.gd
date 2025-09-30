extends State

@export var idle_state : State
@export var jump_state: State
@export var killed_state: State
@export var stunned_state: State

var move_speed =400
func enter():
	pass
func exit():
	pass
func process_physics(delta: float) -> State:

	return null
func process_input(event: InputEvent) -> State:
	return null
