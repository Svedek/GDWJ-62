extends Marker2D

signal target_found(target:Node2D)
signal target_lost()

@export var vision_distance:float = 100.0
@export var raycast_count:int = 5
@export_flags_2d_physics var vision_mask
@export_flags_2d_physics var target_mask

# -45 to 225 degrees
const MIN_ANGLE:float = -0.785398
const MAX_ANGLE:float = 3.92699

var raycasts:Array[RayCast2D]

var target:CharacterBody2D
var target_distance:float = 999999
var target_spotted:bool = false:
	set(value):
		if value == target_spotted:
			return
		target_spotted = value
		if target_spotted:
			emit_signal("target_found", target)
		else:
			emit_signal("target_lost")

func _ready():
	var angle_range:float = MAX_ANGLE - MIN_ANGLE
	for i in range(raycast_count):
		var ray:RayCast2D = RayCast2D.new()
		var angle:float = i * angle_range/(raycast_count-1) + MIN_ANGLE
		ray.hit_from_inside = true
		ray.target_position = Vector2(vision_distance * cos(angle), -vision_distance * sin(angle)) 
		ray.collision_mask = vision_mask
		add_child(ray)
		raycasts.append(ray)
		
func _physics_process(delta):
	var target_found:bool = false
	target_distance = 9999999
	for ray in raycasts:
		if ray.get_collider() is CharacterBody2D and ray.get_collider().collision_layer & target_mask !=0:
			target = ray.get_collider()
			target_found = true
			target_distance = min(target_distance, abs((ray.get_collision_point()-global_position).length()))
	target_spotted = target_found

