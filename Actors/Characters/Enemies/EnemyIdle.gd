extends BaseState

@export_category("State Transitions")
@export var run_node: NodePath

@onready var run_state: BaseState = get_node(run_node)

	
func physics_process(delta):
	if character.target:
		run_state.physics_process(delta)
		return run_state

	character.velocity.x = move_toward(character.velocity.x, 0.0, character.stats.ground_acceleration)
	if !character.is_on_floor():
		character.velocity.y = move_toward(character.velocity.y, character.stats.max_fall_speed, character.stats.gravity)
	character.move_and_slide()
	
	return null
