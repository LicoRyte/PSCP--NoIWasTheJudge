extends Node


#A Service for Emitting Special Effect and Camera Operator
@export var random_strength: float = 30.0
@export var shake_fade: float = 10.0

var rnd := RandomNumberGenerator.new()
var particle = {
	"fracture" : preload("res://Particle/fracture.tscn")
}

func rotate_cam(camera: Camera2D, angle):
	var tween = create_tween()
	tween.tween_property(
		camera, "rotation", angle, 0.5
	)

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

func play_effect(effect : String, position : Vector2):
	var part = particle[effect]
	var part_scene = part.instantiate()
	get_tree().current_scene.add_child(part_scene)
	part_scene.global_position = position
	var actual_particle_node = part_scene.get_node("CPUParticles2D")
	if actual_particle_node:
		do_effect(actual_particle_node)
	
	await get_tree().create_timer(1).timeout
	if part_scene:
		part_scene.queue_free()
	
	
func do_effect(particle_node : CPUParticles2D):
	particle_node.one_shot = true
	particle_node.emitting = true	
	
	
	
