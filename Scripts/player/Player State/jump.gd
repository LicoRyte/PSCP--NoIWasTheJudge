extends State

@export var idle_state : State
@export var run_state: State
@export var killed_state: State
@export var stunned_state: State
@export var dash_state: State

var move_speed = 200.0
var jump_speed = 420.0 #อยากให้กระโดดได้เร็วเท่าไหร่
var gravity_vertical = 1200.0
var height_of_jump = 0.0 #อยากให้กระโดดได้สูงเท่าไหร่
var vertical_jump_speed = 0.0
var is_jumping = false
var immune = true
var dash_direction: Vector2 = Vector2.ZERO
var dash_time_left: float = 0.0
var acceleration = 60

var hitbox : HitboxComponent
var jump_stamina_cost := 0.0 #กระโดดใช้ stamina

func _ready() -> void:
	call_deferred("_assign_hitbox")

func enter():
	player.set_collision_layer_value(1, false)
	player.set_collision_layer_value(2, false)
	#hitbox = Common.get_component(player, HitboxComponent)
	hitbox.set_immune(true)
	if player.stamina_request(jump_stamina_cost):
		player.change_stamina(-jump_stamina_cost)
		player.animated_sprite_2d.play("jump")
		do_jump()
	else:
		print("Not enough stamina to jump")
		return idle_state

func exit():
	player.set_collision_layer_value(1, true)
	player.set_collision_layer_value(2, true)
	hitbox.set_immune(false)

func do_jump() -> void:
	if not is_jumping and height_of_jump <= 0.0:
		is_jumping = true
		vertical_jump_speed = jump_speed
		print("jump", player.current_stamina)

func apply_jump_physics(delta: float) -> void:
	if is_jumping:
		vertical_jump_speed -= gravity_vertical * delta
		height_of_jump += vertical_jump_speed * delta
		
	if height_of_jump <= 0.0:
		height_of_jump = 0.0
		vertical_jump_speed = 0.0
		is_jumping = false
	
	player.animated_sprite_2d.global_position.y = (player.global_position.y - 20) - height_of_jump

func process_physics(delta: float) -> State:
	if dash_time_left <= 0.0:
		player.is_dashing = false
	if player.is_dashing:
		player.velocity = dash_direction * player.dash_speed
		player.move_and_slide()
		dash_time_left -= delta
		apply_jump_physics(delta)

	else:
		var input_direction = Vector2(
			Input.get_action_strength("Right") - Input.get_action_strength("Left"),
			Input.get_action_strength("Down") - Input.get_action_strength("Up")
		).normalized()
		player.velocity = lerp(player.velocity, input_direction * player.current_move_speed, delta * acceleration)
		player.move_and_slide()
		apply_jump_physics(delta)
		if not height_of_jump and input_direction:
			return run_state
		if not height_of_jump and not input_direction:
			return idle_state
	
	if player.is_died:
		return killed_state
	return null

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("Dash") and player.can_dash:
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
	return null

func _assign_hitbox():
	hitbox = Common.get_component(player, HitboxComponent)
