extends TextureProgressBar


func _ready():
	max_value = 75
	GameEvents._on_stamina_changed.connect(_on_player_stamina_changed)


func _on_player_stamina_changed(value: Variant) -> void:
	value = clamp(value, 0, max_value)
	self.value = value
