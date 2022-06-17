extends KinematicBody

var current_hp = 3
var max_hp = 3

var damage = 1
var attack_distance = 1.5
var attack_rate = 1.0

var move_speed = 2.5
var gravity = 15
var velocity = Vector3()


onready var timer = get_node("Timer")
onready var player = get_node("/root/MainScene/Player")

func _ready():
	timer.wait_time = attack_rate
	timer.start()

func _on_Timer_timeout():
	if translation.distance_to(player.translation) < attack_distance:
		player.take_damage(damage)
		
func _physics_process(delta):
	if translation.distance_to(player.translation) > attack_distance:
		var direction = (player.translation - translation).normalized()
		
		velocity.x = direction.x
		velocity.y = 0
		velocity.z = direction.z
		if not is_on_floor():
			velocity.y -= gravity * delta 
		velocity = move_and_slide(velocity * move_speed, Vector3.UP)
	

func take_damage(damage_to_take):
	current_hp -= damage_to_take
	
	if current_hp <= 0:
		queue_free()
