class_name MovingBeachThing extends BeachThing

var move_dir : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	var player : CharacterBody2D
	player = get_tree().get_first_node_in_group("player")
	
	var move_dir : Vector2 = (player.global_position - global_position).normalized()
	
	apply_central_impulse(move_dir * 500)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
