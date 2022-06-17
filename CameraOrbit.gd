extends Spatial

	
var look_sensitivity = 0.5
var min_look_angle = -20.0
var max_look_angle = 75.0

var mouse_delta = Vector2()

onready var player = get_parent()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

# called every frame
func _process(delta):
	# get the rotation to apply to the camera and player
	var rotation = Vector3(mouse_delta.y, mouse_delta.x, 0) * look_sensitivity
	
	# camera vertical rotation
	rotation_degrees.x += rotation.x
	rotation_degrees.x = clamp(rotation_degrees.x, min_look_angle, max_look_angle)
	
	# player horizontal rotation
	player.rotation_degrees.y -= rotation.y
	
	# clear the mouse movement vector
	mouse_delta = Vector2()
	
	
