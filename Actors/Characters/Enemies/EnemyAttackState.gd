extends BaseState

@export var attack_time: float = 0.4

@export_category("State Transitions")
@export var run_node: NodePath

@onready var run_state: BaseState = get_node(run_node)

var attack_timer: Timer
var attacking: bool = false

var move_pos:Vector2

func _ready():
	var  end_attack = func(): attacking = false
	attack_timer = create_timer(end_attack, attack_time)
	
func enter(direction:Vector2):
	super.enter(direction)
	move_pos = character.target.position
	attacking = true
	attack_timer.start()
	character.weapon_container.x_flipped = character.sprite.flip_h
	return null

func physics_process(delta):
	if !attacking:
		return run_state
	var x_move = sign(move_pos.x - character.position.x) * character.stats.move_speed
	
	if !character.is_on_floor():
		character.velocity.x = move_toward(character.velocity.x, x_move*1.5, character.stats.air_acceleration)
		character.velocity.y = move_toward(character.velocity.y, character.stats.max_fall_speed, character.stats.gravity)
	else:
		character.velocity.x = move_toward(character.velocity.x, x_move*1.5, character.stats.ground_acceleration)
	character.move_and_slide()
	
	return null
