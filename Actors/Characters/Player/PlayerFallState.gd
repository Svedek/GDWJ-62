extends BaseState

@export var coyote_time: float = 0.1

@export_category("State Transitions")
@export var idle_node: NodePath
@export var run_node: NodePath
@export var jump_node: NodePath
@export var dash_node: NodePath
@export var air_attack_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var run_state: BaseState = get_node(run_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var air_attack_state: BaseState = get_node(air_attack_node)


func input(event: InputEvent):
	if event.is_action_pressed("jump") && jump_state.available:
		return jump_state
	if event.is_action_pressed("dash") && dash_state.available:
		return dash_state
	if event.is_action_pressed("attack") && air_attack_state.available:
		return air_attack_state
	return null

func physics_process(delta):
	dir = character.get_axis()
	character.velocity.x = move_toward(character.velocity.x, character.stats.move_speed * dir.x, character.stats.air_acceleration)
	if Input.is_action_pressed("ui_down"):
		character.velocity.y = move_toward(character.velocity.y, character.stats.max_fall_speed*1.5, character.stats.gravity)
	else:
		character.velocity.y = move_toward(character.velocity.y, character.stats.max_fall_speed, character.stats.gravity)
	character.move_and_slide()
	if character.is_on_floor():
		return run_state
	return null
