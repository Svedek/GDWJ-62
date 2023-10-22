extends StateManagedCharacter
class_name StateManagedEnemy

@onready var vision = $Vision
@onready var weapon_container = $WeaponContainer

var target: Node2D
var target_distance: float


func get_axis() -> Vector2:
	return Vector2(Input.get_axis("ui_left", "ui_right"), 0.0)

func _physics_process(delta):
	target_distance = vision.target_distance
	super._physics_process(delta)

func _on_vision_target_found(target):
	self.target = target

func _on_vision_target_lost():
	target = null

func _on_hurtbox_on_damaged(damage):
	stats.health -= damage

func _on_character_death():
	# TODO any fun animation or effects
	queue_free()
