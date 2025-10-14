extends TextureProgressBar

@export var player: Player


func _ready():
	GameEvents._hpchanged.connect(update)


func update(amount : float):
	#value = player.current_health * 100 / player.max_health
	value = amount
