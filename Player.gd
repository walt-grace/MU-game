extends KinematicBody

var current_hp = 10
var max_hp = 10
var damage_hp = 1

var gold = 0

var attack_rate = 0.3
var last_attack_time = 0

var move_speed = 5.0
var jump_force  = 50.0
var gravity = 75.0

var velocity = Vector3()

onready var camera = get_node("CameraOrbit")
onready var attack_case = get_node("AttackRayCast")

func _physics_process(delta):
	velocity.x = 0
	velocity.y = 0
	
	var input = Vector3()
	
	# movement inputs
	if Input.is_action_pressed("move_forwards"):
		input.z += 1
	if Input.is_action_pressed("move_backwards"):
		input.z -= 1
	if Input.is_action_pressed("move_left"):
		input.x += 1
	if Input.is_action_pressed("move_right"):
		input.x -= 1
	if Input.is_action_pressed("exit_game"):
		get_tree().quit() # default behavior
		
	
	input = input.normalized()
	
	var direction: Vector3 = (transform.basis.z * input.z + transform.basis.x * input.x)
	
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	print(delta)
	velocity.y -= gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		print("vel y before jump:" ,  velocity.y)
		velocity.y += jump_force
		print("vel y after jump:" ,  velocity.y)
		

	velocity = move_and_slide(velocity, Vector3.UP)

func give_gold(amount):
	gold += amount
