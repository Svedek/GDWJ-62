extends CharacterBody2D
class_name StateManagedCharacter

@onready var stats: CharacterStats = $CharacterStats
@onready var state_manager: StateManager = $StateManager


func _ready():
	state_manager.init(self)
	
func _input(event):
	state_manager.input(event)
	
func _process(delta):
	state_manager.process(delta)

func _physics_process(delta):
	state_manager.physics_process(delta)
	
func get_axis() -> Vector2:
	print("unimplemented get_axis() in - " + self.name)
	return Vector2(Input.get_axis("ui_left", "ui_right"), 0.0)
