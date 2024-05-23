extends CharacterBody2D

@export var max_speed : float = 200
@export var accel : float = 50
@export var decel : float = 10

var current_speed : float


func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction:
		current_speed = move_toward(current_speed, max_speed, accel)
		velocity = input_direction * current_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, decel)
	
	move_and_slide()
	
