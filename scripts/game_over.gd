extends Control

@export var game : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
