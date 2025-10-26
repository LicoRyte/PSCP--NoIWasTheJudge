extends TextureProgressBar

@export var max_stamina: float = 100.0

func _ready():
	max_value = max_stamina
	GameEvents._staminachanged.connect(_on_stamina_changed)
	value = max_stamina

func _on_stamina_changed(new_stamina: float):
	value = new_stamina
