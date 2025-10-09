extends State


@export var idle_state : State
@export var run_state: State
@export var killed_state: State
@export var stunned_state: State


var move_speed = 200.0
var jump_speed = 420.0 #อยากให้กระโดดได้เร็วเท่าไหร่
var gravity_vertical = 1200.0
var height_of_jump = 0.0 #อยากให้กระโดดได้สูงเท่าไหร่
var vertical_jump_speed = 0.0
var is_jumping = false
var immune = true

func enter():
	immune = true
	pass
func exit():
	immune = false	
	pass

func do_jump() -> void:
	if not is_jumping and height_of_jump <= 0.0:
		is_jumping = true
		vertical_jump_speed = jump_speed

func apply_jump_physics(delta: float) -> void:
	if is_jumping:
		vertical_jump_speed -= gravity_vertical * delta
		height_of_jump += vertical_jump_speed * delta
		
	if height_of_jump <= 0.0:
		height_of_jump = 0.0
		vertical_jump_speed = 0.0
		is_jumping = false
	
	player.animated_sprite_2d.offset.y = -height_of_jump

func process_physics(delta: float) -> State:
	do_jump()
	apply_jump_physics(delta)
	if height_of_jump == 0.0:
		return idle_state
	if player.is_died:
		return killed_state
	return null
func process_input(event: InputEvent) -> State:
	return null
