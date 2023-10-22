extends BaseState

@export var min_range:float = 56
@export var max_range:float = 120

@export_category("State Transitions")
@export var idle_node: NodePath
@export var aim_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var aim_state: BaseState = get_node(aim_node)

	
func physics_process(delta):
	if !character.target:
		idle_state.physics_process(delta)
		return idle_state
	var x_move
	if character.target_distance < min_range:
		x_move = -1
	elif character.target_distance > max_range:
		x_move = 1
	else:
		aim_state.physics_process(delta)
		return aim_state
	x_move *= sign(character.target.position.x - character.position.x) * character.stats.move_speed
	character.sprite.flip_h = x_move < 0.0
	if !character.is_on_floor():
		character.velocity.x = move_toward(character.velocity.x, x_move, character.stats.air_acceleration)
		character.velocity.y = move_toward(character.velocity.y, character.stats.max_fall_speed, character.stats.gravity)
	else:
		character.velocity.x = move_toward(character.velocity.x, x_move, character.stats.ground_acceleration)
	character.move_and_slide()
	
	return null
