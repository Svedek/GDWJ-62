extends Node
class_name CharacterStats

signal death

@export var move_speed: float = 250.0
@export var ground_friction: float = 0.8
@export var air_friction: float = 0.5

@export var max_health: int = 1
@onready var health: int = max_health:
	set(value):
		health = value
		if health <= 0:
			on_death()
			
func on_death():
	emit_signal("death")
