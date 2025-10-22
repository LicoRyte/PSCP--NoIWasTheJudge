extends TextureProgressBar

@export var player: Player
@export var max_health: float = 100.0


func _ready():
	max_value = max_health
	GameEvents._hpchanged.connect(_on_hp_changed)
	
func _on_hp_changed(new_health: float):
	value = new_health
	
