extends Node

@export var random_strength: float = 30.0
@export var shake_fade: float = 10.0

var rnd := RandomNumberGenerator.new()

func apply_shake(camera: Camera2D, magnitude: float, lerp_time: float):
	var strength := magnitude
	var fade := lerp_time

	# simple coroutine-based shake
	while strength > 0 and is_instance_valid(camera):
		strength = lerpf(strength, 0, fade * get_process_delta_time())
		camera.offset = Vector2(
			rnd.randf_range(-strength, strength),
			rnd.randf_range(-strength, strength)
		)
		await get_tree().process_frame

	if is_instance_valid(camera):
		camera.offset = Vector2.ZERO
