extends Area2D
class_name BaseHitbox

var collision_shape: CollisionShape2D
var collision_owner: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_owner = get_parent()
	collision_shape = get_node_or_null("Hitbox")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
