extends Area2D

signal died

@export var enemy_speed = randi_range(300, 600)

func _physics_process(delta):
	global_position.x += -enemy_speed * delta


func _on_visible_notifier_screen_exited():
	queue_free()

func die():
	queue_free()
	died.emit()


func _on_body_entered(body):
	body.take_damage()
	die()
