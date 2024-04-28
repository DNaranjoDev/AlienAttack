extends Node2D

@onready var player = $Player
@onready var ui = $UI
@onready var hud = $UI/HUD
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_explode_sound = $PlayerExplodeSound

var gameover_screen = preload("res://Scenes/UI/game_over.tscn")

var lives_count = 3
var score_count = 0

func _ready():
	hud.set_score_label(score_count)
	hud.set_lives_label(lives_count)
	
func _on_player_took_damage():
	lives_count -= 1
	hud.set_lives_label(lives_count)
	if lives_count == 0:
		player_explode_sound.play()
		player.die()
		
		await get_tree().create_timer(1.5).timeout
		var game_over = gameover_screen.instantiate()
		game_over.set_score(score_count)
		ui.add_child(game_over)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score_count += 100
	enemy_hit_sound.play()
	hud.set_score_label(score_count)
