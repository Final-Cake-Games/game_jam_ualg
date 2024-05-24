class_name Game extends Node2D

@onready var hud : Hud = $Hud
@onready var camera_2d = $Camera2D

@export var sfx_array : Array[AudioStream]
@export var min_sfx_cd : float = 4
@export var max_sfx_cd : float = 12

@export var cam_max_speed : float = 200
@export var cam_speed_start : float = 25
@export var time_to_max_seconds : float = 60
@export var chunk : MapSquare

var camera_move_speed : float
var player_points : int = 0
var sfx_cd : float


# Called when the node enters the scene tree for the first time.
func _ready():
	camera_move_speed = cam_speed_start
	
	sfx_cd = randf_range(min_sfx_cd, max_sfx_cd)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sfx_cd -= delta
	if sfx_cd <= 0:
		play_random_sfx()
		sfx_cd = randf_range(min_sfx_cd, max_sfx_cd)
	
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


func play_random_sfx():
	var pick_ear = randi_range(0, 1)
	var ears = [$Camera2D/RightEar, $Camera2D/LeftEar]
	
	SfxManager.play_sfx(sfx_array.pick_random(), ears[pick_ear], 0)
