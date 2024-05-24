class_name BolaBerlim extends RigidBody2D
@onready var sprite_2d = $Sprite2D

var type : String
var str : float

@export var ccreme : CompressedTexture2D
@export var screme : CompressedTexture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if type == "creme":
		sprite_2d.texture = ccreme
	else:
		sprite_2d.texture = screme

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.rotation += 5 * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
