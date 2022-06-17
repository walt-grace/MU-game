extends Node

export (PackedScene) var enemy_scene

func _ready():
	randomize()

func _on_EnemyTimer_timeout():
	print(get_children())
	
	if get_children().size() >= 16:
		return
		
	var enemy = enemy_scene.instance()
	
	var enemy_spawn_location = get_node("Path/PathFollow")
	enemy_spawn_location.unit_offset = randf()
	
	add_child(enemy)
	
	
