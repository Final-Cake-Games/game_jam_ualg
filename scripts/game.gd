class_name Game extends Node2D

@onready var hud : Hud = $Hud
@export var chunk : MapSquare
@export var camera_move_speed : float = 25

@onready var camera_2d = $Camera2D

var player_points : int = 0

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


func _on_player_block_body_entered(body : Player):
	print("game over!")
	get_tree().reload_current_scene()

func add_point():
	player_points+=1
	hud.set_points(player_points)
	
func remove_point():
	player_points-=1
	hud.set_points(player_points)
