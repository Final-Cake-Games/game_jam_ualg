extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func play_sfx(sound : AudioStream, parent_node : Node, volume : float):
	if sound != null or parent_node != null:
		var stream = AudioStreamPlayer2D.new()
		
		stream.stream = sound
		stream.volume_db = volume
		
		stream.connect('finished', stream.queue_free)
		
		parent_node.add_child(stream)
		stream.play()
