extends Control

@onready var score = $Score
@onready var lives = $Lives

func set_score_label(new_score):
	score.text = "Score: " + str(new_score)

func set_lives_label(update_lives):
	lives.text = ": " + str(update_lives)
