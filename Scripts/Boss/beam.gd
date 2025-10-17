extends Node2D

@onready var telegraph: Line2D = $Line2D
@onready var hitbox: Area2D = $Area2D
@onready var beam: Sprite2D = $Sprite2D

@export var delay_before_attack: float = 1.25
@export var fade_time: float = 0.5
@export var beam_damage: float = 10.0

var state = "charge"
var timer = 0.0

func _ready():
	timer = delay_before_attack
	beam.scale.y = 0.0
	hitbox.monitoring = false
	telegraph.visible = true

func _process(delta):
	match state:
		"charge":
			timer -= delta
			if timer <= 0:
				telegraph.visible = false
				hitbox.monitoring = false
				beam.scale.y = 1.0
				state = "attack"
		"attack":
			hitbox.monitoring = true
			for i in hitbox.get_overlapping_bodies():
				if i.has_meta("damaged"):
					continue
				if i == Player:
					i.set_meta("damaged", true)
					Damage.deal_damage(beam_damage, i)
			var tween = create_tween()
			tween.tween_property(beam, "scale:y", 0.0, fade_time)
			await tween.finished
			queue_free()
