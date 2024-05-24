extends Area2D

@export var move_speed : float = 200

var run_dir : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	var player : CharacterBody2D
	player = get_tree().get_first_node_in_group("player")
	
	run_dir = (player.global_position - global_position).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += run_dir * move_speed * delta


func _on_body_entered(body : Player):
	body.slowed.emit()
	queue_free()
	#play hit sound
