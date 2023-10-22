extends BaseState

@export var min_range:float = 48
@export var max_range:float = 160
@export var fire_delay:float = 0.75

@export_category("State Transitions")
@export var idle_node: NodePath
@export var run_node: NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var run_state: BaseState = get_node(run_node)

var fire_timer: Timer

var move_pos:Vector2

func _ready():
	fire_timer = create_timer(fire, fire_delay)
	fire_timer.one_shot = false
	
func enter(direction:Vector2):
	super.enter(direction)
	move_pos = character.target.position
	fire_timer.start()
	return null
	
func exit() -> Vector2:
	fire_timer.stop()
	return super.exit()
	
func physics_process(delta):
	if !character.target:
		return idle_state
	if character.target_distance < min_range or character.target_distance > max_range:
		return run_state
		
	character.rotate_weapon((character.target.global_position - character.global_position).angle())
	if !character.is_on_floor():
		character.velocity.x = move_toward(character.velocity.x, 0.0, character.stats.air_acceleration)
		character.velocity.y = move_toward(character.velocity.y, character.stats.max_fall_speed, character.stats.gravity)
	else:
		character.velocity.x = move_toward(character.velocity.x, 0.0, character.stats.ground_acceleration)
	character.move_and_slide()
	
	return null

func fire():
	var proj = character.projectile.instantiate()
	proj.init(character.firepoint.global_position, Vector2.from_angle(character.firepoint.global_rotation))
	add_child(proj)
