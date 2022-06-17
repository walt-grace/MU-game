extends KinematicBody

var current_hp = 10
var max_hp = 10
var damage_hp = 1

var gold = 0

var attack_rate = 0.3
var last_attack_time = 0

var move_speed = 10.0
var jump_force  = 10.0
var gravity = 15.0

var velocity = Vector3.ZERO

onready var camera = get_node("CameraOrbit")
onready var attack_cast = get_node("AttackRayCast")
onready var ui = get_node("CanvasLayer/UI")

func _ready():
	ui.update_health_bar(current_hp)
	ui.update_gold_text(gold)

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		try_attack()

func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	
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
	
	if input != Vector3.ZERO:
		input = input.normalized()
	
	var direction: Vector3 = (transform.basis.z * input.z + transform.basis.x * input.x)
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	velocity.y -= gravity * delta

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force 
	velocity = move_and_slide(velocity, Vector3.UP)

func try_attack():
	if (OS.get_ticks_msec() - last_attack_time) < attack_rate * 1000:
		return
	
	last_attack_time = OS.get_ticks_msec()
	
	var sword_animator = $WeaponHolder/SwordAnimator
	
	sword_animator.stop()
	sword_animator.play("attack")
	
	if attack_cast.is_colliding():
		if attack_cast.get_collider().has_method("take_damage"):
			attack_cast.get_collider().take_damage(damage_hp)

func give_gold(amount):
	gold += amount
	ui.update_gold_text(gold)
	
func take_damage (damage_to_take):
	current_hp -= damage_to_take
	ui.update_health_bar(current_hp)
	
	if current_hp <= 0:
		get_tree().reload_current_scene()	
		
		
