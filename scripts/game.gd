class_name Game extends Node2D

@export var chunk : MapSquare
@export var camera_move_speed : float = 25

@onready var camera_2d = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	move_camera(delta)
	
func move_camera(delta : float) -> void:
	camera_2d.position.y -= camera_move_speed * delta
