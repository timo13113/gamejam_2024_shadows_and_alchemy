extends CharacterBody2D

@export var speed = 15000
var toggle = false

func _input(event):
	if event.is_action_pressed("toggle_move"):
		toggle = true
	if event.is_action_released("toggle_move"):
		toggle = false

func _physics_process(delta):
	look_at(get_global_mouse_position())
	#velocity = speed * delta * transform.x * int(toggle)
	velocity = speed * delta * transform.x
	#velocity = speed * delta * Input.get_vector(
		#"ingame_move_left", "ingame_move_right", 
		#"ingame_move_up", "ingame_move_down")
	move_and_slide()
	
