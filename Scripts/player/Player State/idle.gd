extends State

@export var run_state : State
@export var jump_state: State
@export var killed_state: State
@export var stunned_state: State
@export var dash_state: State

func enter():
	#print("Hello")
	player.animated_sprite_2d.play("Idle")
func exit():
	pass
func process_physics(delta: float) -> State:
	var input_direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	)
	if input_direction:
		return run_state
	if player.is_died:
		return killed_state
	return null

func process_input(event: InputEvent) -> State:
	
	"""ตัวแปร ตรวจสอบว่า player ขยับไหม"""
	
	"""กระโดด"""
	if Input.is_action_just_pressed("Space"):
		return jump_state

	"""dash"""
	if Input.is_action_just_pressed("Dash") and player.can_dash and player.stamina_request(player.dash_stamina_cost):
		return dash_state
	
	"""run"""
	
	"""die"""

	return null
