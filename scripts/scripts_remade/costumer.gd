class_name Costumer extends BeachThing

signal order_made
signal order_success
signal order_failed
signal no_order

@onready var request_bubble : AnimatedSprite2D = $RequestBubble
@onready var progress_bar : ProgressBar = $ProgressBar
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var turma_textures : Array[CompressedTexture2D]
@export var min_wait_time : int = 3
@export var max_wait_time : int = 6

@export var eat_sfx : AudioStream


var order_options : Array[String] = ['creme', 'screme', '', 'creme', 'screme', 'creme', 'screme']

var order_choice : String
var wait_time : float

var waiting_for_order : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = randi_range(min_wait_time, max_wait_time)
	progress_bar.max_value = wait_time
	order_choice = order_options.pick_random()
	sprite_2d.texture = turma_textures.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if waiting_for_order:
		await_order(delta)

func await_order(delta : float):
	wait_time -= delta
	progress_bar.value = wait_time
	
	if wait_time <= 0:
		waiting_for_order = false
		order_failed.emit()

func _on_no_order():
		progress_bar.visible = false

func _on_order_made():
	request_bubble.play(order_choice)
	waiting_for_order = true

func _on_order_failed():
	animation_player.play("react")
	progress_bar.visible = false
	request_bubble.play("mad")

func _on_order_success():
	animation_player.play("react")
	waiting_for_order = false
	progress_bar.visible = false
	request_bubble.play("happy")

func _on_berlim_detector_body_entered(body : BolaBerlim):	
	if waiting_for_order:
		if body.type == order_choice:
			order_success.emit()
			
			var player : Player = get_tree().get_first_node_in_group("player")
			player.boost()
		else:
			order_failed.emit()

func _on_visible_on_screen_notifier_2d_screen_entered():
	if (waiting_for_order == false and 
	(request_bubble.animation == "new_animation")):
		if order_choice == "": 
			no_order.emit()
		else:
			order_made.emit()
