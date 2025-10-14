extends State

@export var idle_state : State
@export var jump_state: State
@export var killed_state: State
@export var stunned_state: State

var move_speed = 200
var acceleration = 60

func enter():
	player.animated_sprite_2d.play("run")
func exit():
	pass 

func process_physics(delta: float) -> State:
	var input_direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	).normalized()
	player.velocity = lerp(player.velocity, input_direction * player.current_move_speed, delta * acceleration)
	player.move_and_slide()

	"""หันซ้ายขวาของ sprite ผู้เล่น"""
	if input_direction.x > 0:
		player.animated_sprite_2d.flip_h = false
	elif input_direction.x < 0:
		player.animated_sprite_2d.flip_h = true
	if Input.is_action_just_pressed("Space"):
		return jump_state
	if not player.velocity:
		return idle_state
	if player.is_died:
		return killed_state
	return null
func process_input(event: InputEvent) -> State:
	return null
