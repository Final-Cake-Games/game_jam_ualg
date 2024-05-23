class_name MapSquare extends Node2D

@onready var screen_status_notifier : VisibleOnScreenNotifier2D = $ScreenStatusNotifier
@onready var new_chunk_pos : Marker2D = $NewChunkPos

var chunk_holder : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	chunk_holder = get_tree().get_first_node_in_group("chunks")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_screen_status_notifier_screen_exited():
	# On screen exit delete chunk
	queue_free()

func _on_screen_status_notifier_screen_entered():
	print(chunk_holder)
	if chunk_holder != null:
		var new_chunk = self.duplicate(8)
		new_chunk.global_position = new_chunk_pos.global_position
		chunk_holder.add_child(new_chunk) 
