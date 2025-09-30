extends Area2D
class_name BaseHitbox

var collision_shape: CollisionShape2D
var collision_owner: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent() is Node2D:
		collision_owner = get_parent()
	if self.get_children():
		collision_shape = get_child(0)
	if not self.is_connected("body_entered", _on_body_entered):
		connect("body_entered", _on_body_entered)
		print_debug("connect")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	Damage.deal_damage(30, body)
	if body == collision_owner:
		return
