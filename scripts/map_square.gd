class_name MapSquare extends Node2D

@export var beach_things_array : Array [PackedScene] 

@onready var screen_status_notifier : VisibleOnScreenNotifier2D = $ScreenStatusNotifier
@onready var new_chunk_pos : Marker2D = $NewChunkPos
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var positions : Node2D = $Positions

var positions_array : Array
var chunk_holder : Node
var game_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	game_node = get_parent().get_parent()
	positions_array = positions.get_children()
	chunk_holder = get_tree().get_first_node_in_group("chunks")
	#load_random_sprite()
	
	for position in positions_array:
		var beach_thing = beach_things_array.pick_random().instantiate()
		beach_thing.position.x += randf_range(-5 , 5)
		beach_thing.position.y += randf_range(-5 , 5)
		position.add_child(beach_thing)
		
		if beach_thing is Costumer:
			beach_thing.order_success.connect(add_point_trigger)
			beach_thing.order_failed.connect(retract_point_trigger)
		

func _on_screen_status_notifier_screen_exited():
	# On screen exit delete chunk
	queue_free()

func _on_screen_status_notifier_screen_entered():
	if chunk_holder != null:
		var new_chunk = self.duplicate(8) # Duplicate the chunk scene
		new_chunk.load_random_sprite() # Load a random background to new chunk
		new_chunk.global_position = new_chunk_pos.global_position # Place chunk in appropriate pos
		chunk_holder.add_child(new_chunk) # Place chunk in world

func load_random_sprite():
	pass

func add_point_trigger():
	game_node.add_point()
func retract_point_trigger():
	game_node.remove_point()
