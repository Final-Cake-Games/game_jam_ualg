class_name BolaBerlim extends RigidBody2D

var type : String
var str : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# if creme sprite creme else sprite ncreme

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.rotation += 15

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
