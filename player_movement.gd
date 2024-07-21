extends CharacterBody2D

@export var speed = 15000

func _physics_process(delta):
	
	velocity = speed * delta * Input.get_vector("ingame_move_left", "imgame_move_right", "ingame_move_up", "ingame_move_down")
	move_and_slide()
	
