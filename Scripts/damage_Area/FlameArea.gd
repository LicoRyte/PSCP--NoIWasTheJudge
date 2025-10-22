extends BaseHitbox


# Called when the node enters the scene tree for the first time.
func emit_damage(body: Node2D):
	if body is Entity:
		Damage.deal_damage(25, body)
		Damage.inflict_chill(5, -0.8, 5, body)
		Damage.inflict_flame(1,3,0.1, body)
