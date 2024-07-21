extends CharacterBody2D

class_name Player

@export var speed = 15000
var toggle_move = false
#var toggle_strong_light = false

func _input(event):
	if event.is_action_pressed("toggle_move"):
		toggle_move = true
	if event.is_action_released("toggle_move"):
		toggle_move = false

func _physics_process(delta):
	look_at(get_global_mouse_position())
	#velocity = speed * delta * transform.x * int(toggle_move)
	velocity = speed * delta * transform.x
	#velocity = speed * delta * Input.get_vector(
		#"ingame_move_left", "ingame_move_right", 
		#"ingame_move_up", "ingame_move_down")
	move_and_slide()
