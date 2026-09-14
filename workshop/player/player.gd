class_name Player extends CharacterBody3D
@export var gravity = 40.0
@export var run_speed = 8.0
@export var jump_speed = 14.0
@export var double_jump_wind = 200.0	## Khung thời gian double jump
@export var friction = 20 ## Ma sát trên ground
@onready var animation: AnimatedSprite3D = $AnimatedSprite3D
@onready var player_state: StateMachine = $PlayerState		## Player State machine (temp)
var previous_position ## Giữ vị trí frame trước đó

var time_landed_started : int = 0	## Thời điểm đáp đất
var coins = 0

@onready var ModulateDefault = $AnimatedSprite3D.modulate

func _ready() -> void:
	player_state.Initialized()
	pass
func _physics_process(delta: float) -> void:
	# Trọng lực
	velocity.y -= delta * gravity
	
	# Xử lí input movement cơ bản
	get_input(delta)
	
	# Flip sprite theo direction	
	if velocity.x < 0:
		animation.flip_h = true
	elif velocity.x > 0:
		animation.flip_h = false
	
	# Double jump 
	if is_on_floor():
		if time_landed_started == 0:
			time_landed_started = Time.get_ticks_msec() 
		# effect nếu có thể trigger double jump
		if Time.get_ticks_msec() - time_landed_started < double_jump_wind:
			animation.modulate = Color(1, 0, 0, 1)
		else: 
			animation.modulate = ModulateDefault
	else :
		time_landed_started = 0
		animation.modulate = ModulateDefault
		
	previous_position = position
	move_and_slide()

## basic movement input
func get_input(delta: float) -> void:
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	if left:
		velocity.x = -run_speed
	elif right:
		velocity.x = run_speed
	else: 
		if is_on_floor():
			velocity.x = move_toward(velocity.x,0.0,delta * friction)
	if jump && is_on_floor():
		var time_jump_started = Time.get_ticks_msec()
		if time_jump_started - time_landed_started > double_jump_wind:
			velocity.y += jump_speed  
		else:
			velocity.y += jump_speed * 1.5

func add_coin() -> void:
	coins += 1
	print("Total coins: ", coins)
	pass











# * Notes: Không update movement trong state idle/walk/jump 
# để code không bị khác xa yêu cầu bài thực hành
