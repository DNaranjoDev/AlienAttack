extends Node2D

@onready var spawn_positions = $SpawnPositions

var enemy_scene = preload("res://Scenes/Enemies/enemy.tscn")

signal enemy_spawned(enemy_instance)

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
