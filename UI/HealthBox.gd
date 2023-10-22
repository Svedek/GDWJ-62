extends HBoxContainer

const MAX_HEALTH:int = 3
var hearts:Array[TextureRect]

@export var full_heart:Texture2D
@export var empty_heart:Texture2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(MAX_HEALTH):
		var heart:TextureRect = TextureRect.new()
		heart.texture = full_heart
		heart.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		add_child(heart)
		hearts.append(heart)

func update_hearts(health:int):
	for i in range(hearts.size()):
		hearts[i].texture = full_heart if i < health else empty_heart

