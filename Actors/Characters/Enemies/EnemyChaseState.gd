extends BaseState

@export var attack_range:float = 32.0

@export_category("State Transitions")
@export var idle_node: NodePath
@export var attack_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var attack_state: BaseState = get_node(attack_node)

	
func physics_process(delta):
	if !character.target:
		idle_state.physics_process(delta)
		return idle_state
	if character.target_distance <= attack_range and attack_state.available:
		attack_state.physics_process(delta)
		return attack_state
	
	var x_move = sign(character.target.position.x - character.position.x) * character.stats.move_speed
	character.sprite.flip_h = x_move < 0.0
	if !character.is_on_floor():
		character.velocity.x = move_toward(character.velocity.x, x_move, character.stats.air_acceleration)
		character.velocity.y = move_toward(character.velocity.y, character.stats.max_fall_speed, character.stats.gravity)
	else:
		character.velocity.x = move_toward(character.velocity.x, x_move, character.stats.ground_acceleration)
	character.move_and_slide()
	
	return null
