class_name BeachThing extends RigidBody2D

@export var knock_back_time : float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func knock_back(dir : Vector2, str : float):
	#velocity = dir * str
	#await get_tree().create_timer(knock_back_time).timeout
	#velocity = velocity.move_toward(Vector2.ZERO, str / 4)	
	pass
