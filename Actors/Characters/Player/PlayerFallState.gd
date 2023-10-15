extends BaseState

@export_category("State Transitions")
@export var idle_node: NodePath
@export var run_node: NodePath
@export var jump_node: NodePath
@export var dash_node: NodePath
@export var attack_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var run_state: BaseState = get_node(run_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var attack_state: BaseState = get_node(attack_node)


func input(event: InputEvent):
	if event.is_action_pressed("jump") && jump_state.available:
		return jump_state
	if event.is_action_pressed("dash") && dash_state.available:
		return dash_state
	if event.is_action_pressed("attack") && attack_state.available:
		return attack_state
	
	dir = character.get_axis()
	if dir.x != 0:
		return run_state
	return null
