extends Area2D

@export var speed:float = 320.0
@export var damage:int = 1
var initialized:bool = false
var move_dir:Vector2

func init(pos:Vector2, dir:Vector2):
	move_dir = dir * speed
	position = pos
	monitorable = true
	monitoring = true
	initialized = true

func _physics_process(delta):
	position += move_dir * delta

func _on_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_body_entered(body):
	queue_free()

func take_damage(damage:int):
	queue_free()

