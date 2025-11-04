extends State

@export var idle_state : State
@export var jump_state: State
@export var killed_state: State
@export var stunned_state: State
@export var dash_state: State

var move_speed = 200
var acceleration = 60
var temp := Vector2.ZERO

func enter():
	player.animated_sprite_2d.play("run")
func exit():
	pass

func process_physics(delta: float) -> State:
	
	"""การขยับของ player"""
	var input_direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	).normalized()
	player.velocity = lerp(player.velocity, input_direction * player.current_move_speed, delta * acceleration)
	player.move_and_slide()
	
	"""ตัวแปรการ dash"""
	if not input_direction:
		player.last_input_direction = temp
		#print("last_input_direction", player.last_input_direction)
	temp = input_direction
	"""หันซ้ายขวาของ sprite ผู้เล่น"""
	if input_direction.x > 0:
		player.animated_sprite_2d.flip_h = false
	elif input_direction.x < 0:
		player.animated_sprite_2d.flip_h = true
		
	"""กระโดด"""
	if Input.is_action_just_pressed("Space"):
		return jump_state
		
	"""หยุด"""
	if not input_direction:
		return idle_state
		
	"""dash"""
	if Input.is_action_just_pressed("Dash") and player.can_dash and player.stamina_request(player.dash_stamina_cost):
		return dash_state
	else:
		print("Not enough stamina to dash")
		
	"""die"""
	if player.is_died:
		return killed_state
	
	return null
func process_input(_event: InputEvent) -> State:
	return null
