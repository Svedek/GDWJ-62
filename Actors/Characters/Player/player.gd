extends CharacterBody2D


@onready var stats: CharacterStats = $CharacterStats
@onready var state_manager: StateManager = $StateManager

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _input(event):
	state_manager.input(event)
	
	
func _process(delta):
	state_manager.process(delta)


func _physics_process(delta):
	state_manager.physics_process(delta)
	
func get_axis() -> Vector2:
	return Vector2(Input.get_axis("ui_left", "ui_right"), 0.0)

func _on_character_death():
	pass # Replace with function body.
