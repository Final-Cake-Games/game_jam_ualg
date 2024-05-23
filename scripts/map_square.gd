class_name MapSquare extends Node2D

@onready var screen_status_notifier : VisibleOnScreenNotifier2D = $ScreenStatusNotifier
@onready var new_chunk_pos : Marker2D = $NewChunkPos
@onready var sprite_2d : Sprite2D = $Sprite2D

var chunk_holder : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	chunk_holder = get_tree().get_first_node_in_group("chunks")
	load_random_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_screen_status_notifier_screen_exited():
	# On screen exit delete chunk
	queue_free()

func _on_screen_status_notifier_screen_entered():
	if chunk_holder != null:
		var new_chunk = self.duplicate(8) # Duplicate the chunk scene
		new_chunk.load_random_sprite() # Load a random background to new chunk
		new_chunk.global_position = new_chunk_pos.global_position # Place chunk in appropriate pos
		chunk_holder.add_child(new_chunk) # Place chunk in world

#func get_files(path):
	#var files = []
	#var dir = DirAccess.new()
	#dir.open(path)
	#dir.list_dir_begin(true)
#
	#var file = dir.get_next()
	#while file != '':
		#files += [file]
		#file = dir.get_next()
#
	#return files

func load_random_sprite():
	pass
