class_name Sombrinha extends StaticObject 

@export var sombrinhas_textures : Array[CompressedTexture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = sombrinhas_textures.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
