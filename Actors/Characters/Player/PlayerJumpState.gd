extends BaseState

@export var jump_time: float
@export var jump_velocity: float = -250

@export_category("State Transitions")
@export var fall_node: NodePath
@export var dash_node: NodePath
@export var air_attack_node: NodePath

@onready var fall_state: BaseState = get_node(fall_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var air_attack_state: BaseState = get_node(air_attack_node)


var jump_timer: Timer
var jumping: bool = false


func _ready():
	var  end_jump = func(): jumping = false
	jump_timer = create_timer(end_jump, jump_time)

func enter(direction:Vector2):
	super.enter(direction)
	jumping = true
	jump_timer.start()
	return null

func exit() -> Vector2:
	return dir
	
func input(event: InputEvent):
	if event.is_action_pressed("dash") && dash_state.available:
		return dash_state
	if event.is_action_pressed("attack") && air_attack_state.available:
		return air_attack_state

func physics_process(delta: float) -> BaseState:
	dir = character.get_axis()
	if !Input.is_action_pressed("jump") || !jumping:
		if !Input.is_action_pressed("jump"):
			character.velocity.y = 0
		return fall_state
	
	character.velocity.x = move_toward(character.velocity.x, character.stats.move_speed * dir.x, character.stats.air_acceleration )
	character.velocity.y = jump_velocity
	
	character.move_and_slide()
	return null
