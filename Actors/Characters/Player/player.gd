extends StateManagedCharacter

signal player_health_update(current_health:int)
signal player_death()

@onready var weapon_container = $WeaponContainer


func get_axis() -> Vector2:
	return Vector2(Input.get_axis("ui_left", "ui_right"), 0.0)

func _on_character_death():
	emit_signal("player_death")

func _on_hurtbox_on_damaged(damage):
	stats.health -= damage
	emit_signal("player_health_update", stats.health)
