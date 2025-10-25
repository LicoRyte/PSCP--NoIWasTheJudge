extends Area2D
class_name CardAreaComponent

@export var hitbox: CollisionShape2D
@export var sprite: Sprite2D

signal chosen(card: CardResource)

var card : CardResource

func _ready() -> void:
	if not hitbox:
		hitbox = Common.get_component(self, CollisionShape2D)
	if not sprite:
		sprite = Common.get_component(self, Sprite2D)

	connect("mouse_entered", _on_mouse_entered)
	connect("input_event", _on_input_event)
	connect("mouse_exited", _on_mouse_exit )

func _on_mouse_entered() -> void:
	if card:
		GameEvents.update_description(card._get_name(), card._get_description(), card._get_stat())
func _on_mouse_exit() -> void:
	GameEvents.update_description("", "", "")

func set_card(c : CardResource):
	card = c
	_refresh()

func _refresh():
	if card and sprite:
		sprite.texture = card.card_image
		set_collision_shape()

func set_collision_shape():
	if not hitbox or not sprite or not sprite.texture:
		return
	var tex_size = sprite.texture.get_size()
	if hitbox.shape is RectangleShape2D:
		hitbox.shape.size = tex_size
	elif hitbox.shape == null:
		var shape = RectangleShape2D.new()
		shape.size = tex_size
		hitbox.shape = shape

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		chosen.emit(card)
