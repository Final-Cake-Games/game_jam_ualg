extends CharacterBody2D

@onready var progress_bar : ProgressBar = $ProgressBar

@export var max_speed : float = 200
@export var accel : float = 50
@export var decel : float = 10
@export var throw_adder : float = 500

@export var max_throw_str : float = 1200

var bola_berlim = load("res://scenes/bola_berlim.tscn")
var bolas_holder : Node

var curr_throw : float = 0
var current_speed : float
var mouse_pos : Vector2

func _ready():
	progress_bar.max_value = max_throw_str
	bolas_holder = get_tree().get_first_node_in_group("bolas")

func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	look_at(mouse_pos.move_toward(get_global_mouse_position(), 5)) # Make smooth
	#lerp()
	
	if (Input.is_action_pressed("throw_1") or 
		Input.is_action_pressed("throw_2")):
			charge_throw(delta)
	
	if Input.is_action_just_released("throw_1"):
		throw_bola("screme")
		curr_throw = 0
		
	if Input.is_action_just_released("throw_2"):
		throw_bola("creme")
		curr_throw = 0
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction:
		current_speed = move_toward(current_speed, max_speed, accel)
		velocity = input_direction * current_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, decel)
	
	move_and_slide()
	
func charge_throw(delta):
	#show ui charge
	progress_bar.value = curr_throw
	if curr_throw < max_throw_str:
		curr_throw += throw_adder * delta

func throw_bola( type : String):
	progress_bar.value = 0
	if bolas_holder != null:
		var new_bola : BolaBerlim = bola_berlim.instantiate()
		new_bola.position = position
		new_bola.type = type
		bolas_holder.add_child(new_bola)
		var direction : Vector2 = (get_global_mouse_position() - global_position).normalized()
		new_bola.apply_impulse(direction * curr_throw)
	
