extends Node
class_name StateMachine

@export var starting_state : State
var current_state : State
# Called when the node enters the scene tree for the first time.
func initialize(p: Player):
	#Set The Owner Of Children State in the state Machine
	for child in get_children():
		child.player = p
	
	current_state = starting_state
func change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	if current_state:
		current_state.enter()


func process_physics(delta: float):
	var next = current_state.process_physics(delta)
	if next:
		change_state(next)
func process_events(event: InputEvent):
	var next = current_state.process_input(event)
	if next:
		change_state(next)
