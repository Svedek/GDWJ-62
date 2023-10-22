extends StateManagedEnemy

@export var projectile:PackedScene
@onready var weapon_sprite:Sprite2D = $WeaponSprite2D
@onready var firepoint:Node2D = $WeaponSprite2D/Firepoint

func rotate_weapon(radians:float):
	weapon_sprite.global_rotation = radians
	if radians < PI/2 and radians > -PI/2:
		weapon_sprite.flip_v = false
		sprite.flip_h = false
	else:
		weapon_sprite.flip_v = true
		sprite.flip_h = true
