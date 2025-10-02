extends Area2D
class_name BaseHitbox

"""เป็นฐานสำคัญของระบบ hitboxes โจมตี"""
"""หากมี object เข้ามาในพื้นที่ Area2D จะทำการเรียกฟังก์ชั่น emit_body()"""
"""เอาไป extends และทำต่อได้ตามสบาย"""

var collision_shape: CollisionShape2D
var collision_owner: Node2D
var damage: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent() is Node2D:
		collision_owner = get_parent()
	if self.get_children():
		collision_shape = get_child(0)
	if not self.is_connected("body_entered", _on_body_entered):
		connect("body_entered", _on_body_entered)
		print_debug("connect")


func _on_body_entered(body: Node2D) -> void:
	emit_damage(body)


func emit_damage(body: Node2D):
	if body == collision_owner:
		return
