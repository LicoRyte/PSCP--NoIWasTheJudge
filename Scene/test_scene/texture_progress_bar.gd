extends TextureProgressBar


func _ready():
	max_value = 100


func _on_player_stamina_changed(value: Variant) -> void:
	value = clamp(value, 0, max_value)
	self.value = value
