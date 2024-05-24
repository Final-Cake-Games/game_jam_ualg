class_name Costumer extends Area2D

signal order_success
signal order_failed

enum ORDER_STATUS { MADE, FULFILLED, FAILED_TIME, FAILED_TYPE, NO_ORDER }

@onready var request_bubble : AnimatedSprite2D = $RequestBubble
@onready var progress_bar : ProgressBar = $ProgressBar
@onready var sprite_2d : Sprite2D = $Sprite2D

@export var turma_textures : Array[CompressedTexture2D]
@export var min_wait_time : int = 3
@export var max_wait_time : int = 6

var order_options : Array[String] = ['creme', 'screme', '']

var order_choice : String
var wait_time : float

var current_order_status : int
var in_frame : bool = false
var signaled : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = randi_range(min_wait_time, max_wait_time)
	progress_bar.max_value = wait_time
	order_choice = order_options.pick_random()
	sprite_2d.texture = turma_textures.pick_random()
	
	if order_choice == "": progress_bar.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if in_frame:
		match current_order_status:
			ORDER_STATUS.MADE:
				wait_time -= delta # Countdown
				progress_bar.value = wait_time # Update bar
				
				if wait_time <= 0: 
					current_order_status = ORDER_STATUS.FAILED_TIME
					if signaled == false:
						request_bubble.play("mad")
						progress_bar.visible = false
						order_failed.emit()
						signaled = true
			ORDER_STATUS.FULFILLED:
				#print("YAY! Happy costumer")
				pass
			ORDER_STATUS.FAILED_TIME:
				#print("Failed by time")	
				pass
			ORDER_STATUS.FAILED_TYPE:
				#print("Failed by type")	
				pass
			ORDER_STATUS.NO_ORDER:
				pass

		
func _on_visible_on_screen_notifier_2d_screen_entered():
	# Costumer entered screen, ready to play!
	if order_choice != '':
		in_frame = true
		progress_bar.visible = true
		start_order()
	else:
		# Is merely an obstacle
		progress_bar.visible = false
		current_order_status = ORDER_STATUS.NO_ORDER

func _on_body_entered(body : BolaBerlim):
	if current_order_status == ORDER_STATUS.MADE:
		if body.type == order_choice:
			current_order_status = ORDER_STATUS.FULFILLED
			request_bubble.play("happy")
			progress_bar.visible = false
			order_success.emit()
			
		else:
			current_order_status = ORDER_STATUS.FAILED_TYPE
			request_bubble.play("mad")
			progress_bar.visible = false
			order_failed.emit()
		
	body.queue_free()

func start_order():
	current_order_status = ORDER_STATUS.MADE
	request_bubble.play(order_choice)

