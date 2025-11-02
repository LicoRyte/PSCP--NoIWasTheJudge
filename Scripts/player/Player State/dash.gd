extends State

@export var idle_state : State
@export var run_state: State
@export var jump_state: State
@export var killed_state: State
@export var stunned: State

var dash_direction: Vector2 = Vector2.ZERO
var dash_time_left: float = 0.0
var acceleration = 60

func enter():
	player.is_dashing = true
	player.change_stamina(-0)
	#print("before_input_direction", player.last_input_direction)
	player._dash_cd_left = player.dash_cooldown
	player.can_dash = false
	
	var input_dir = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	).normalized()
	
	if input_dir:
		dash_direction = input_dir
	else:
		dash_direction = player.last_input_direction
	
	dash_time_left = player.dash_cooldown
	
	player.animated_sprite_2d.play("dash")

func exit():
	player.is_dashing = false

func process_physics(delta: float) -> State:
	player.velocity = dash_direction * player.dash_speed
	player.move_and_slide()
	
	dash_time_left -= delta
	if dash_time_left <= 0.0:
		if jump_state.is_jumping:
			return jump_state
		var input_direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	).normalized()
		player.velocity = lerp(player.velocity, input_direction * player.current_move_speed, delta * acceleration)
		player.move_and_slide()
		if input_direction:
			return run_state
		else:
			return idle_state
	return null
func process_input(_event: InputEvent) -> State:
	return null
