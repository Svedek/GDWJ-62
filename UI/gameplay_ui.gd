extends Control

@onready var health_box = %HealthHBox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_player_health_update(current_health:int):
	health_box.update_hearts(current_health)
