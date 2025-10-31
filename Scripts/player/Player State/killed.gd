extends State

@export var idle_state : State
@export var run_state: State
@export var jump_state: State
@export var stunned_state: State
@export var dash_state: State

func enter():
	SceneManager.play_summary()
func exit():
	pass
func process_physics(delta: float) -> State:
	return null
func process_input(event: InputEvent) -> State:
	return null
