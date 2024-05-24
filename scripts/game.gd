class_name Game extends Node2D

@onready var hud : Hud = $Hud
@onready var camera_2d = $Camera2D

@export var cam_max_speed : float = 200
@export var cam_speed_start : float = 25
@export var time_to_max_seconds : float = 60
@export var chunk : MapSquare

var camera_move_speed : float
var player_points : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_move_speed = cam_speed_start

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	move_camera(delta)
	camera_move_speed = move_toward(camera_move_speed, cam_max_speed, ((cam_max_speed - cam_speed_start) / time_to_max_seconds) * delta)
	
	
func move_camera(delta : float) -> void:
	camera_2d.position.y -= camera_move_speed * delta


func _on_player_block_body_entered(body : Player):
	print("game over!")
	get_tree().reload_current_scene()

func add_point():
	player_points+=1
	hud.set_points(player_points)
	
func remove_point():
	player_points-=1
	hud.set_points(player_points)
