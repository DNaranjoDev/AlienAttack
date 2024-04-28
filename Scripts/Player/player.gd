extends CharacterBody2D

@onready var rocket_container = $RocketContainer
@onready var rocket_shoot_sound = $RocketShootSound

signal took_damage

@export var max_speed = 500.0
@export var accel = 1600
@export var friction = 600

var input = Vector2.ZERO
var rocket_scene = preload("res://Scenes/Player/rocket.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot_rocket()

func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	player_movement(delta)
	# To limit the movement into the screen
	global_position = global_position.clamp(Vector2(0,0), screen_size)

func get_input():
	input.x = float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left"))
	input.y = float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func shoot_rocket():
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 50
	rocket_shoot_sound.play()

func take_damage():
	took_damage.emit()
	
func die():
	queue_free()
