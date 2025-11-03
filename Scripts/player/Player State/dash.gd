extends State

@export var idle_state : State
@export var run_state: State
@export var jump_state: State
@export var killed_state: State
@export var stunned: State
@onready var hitbox = $"../../hitbox_player"
var dash_direction: Vector2 = Vector2.ZERO
var dash_time_left: float = 0.0
var acceleration = 60
var dash_damage := 5

func enter():
	hitbox.set_collision_mask_value(8, true)
	hitbox.set_collision_layer_value(1, false)
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
	hitbox.set_collision_mask_value(8, false)
	hitbox.set_collision_layer_value(1, true)
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

func apply_hit(target: Node2D):
	var hitbox = Common.get_component(target, HitboxComponent)
	#print(hitbox)
	if not hitbox:
		return
	Damage.deal_damage(dash_damage, hitbox)

func _on_hitbox_player_area_entered(area: Area2D) -> void:
	#print("player_hit")
	GameEvents._shake_call.emit()
	GlobalAudio.fx("damage")
	apply_hit(area.get_parent())
