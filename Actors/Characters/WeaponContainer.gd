extends Node2D

@onready var components:Array[Node] = get_children(true)

var x_flipped:bool = false:
	set(value):
		if x_flipped != value:
			for component in components:
				component.position.x *= -1
				if component is Sprite2D:
					component.flip_h = !component.flip_h
					component.show_behind_parent = !component.show_behind_parent
		x_flipped = value
