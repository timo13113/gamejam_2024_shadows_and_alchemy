extends CharacterBody2D

class_name Player

@export var speed = 15000
var toggle_move = false
#var toggle_strong_light = false
var kin_collision : KinematicCollision2D
var collided_with : Node2D
@export var hp : int = 1

func _input(event):
	if event.is_action_pressed("toggle_move"):
		toggle_move = true
	if event.is_action_released("toggle_move"):
		toggle_move = false

func _physics_process(delta):
	look_at(get_global_mouse_position())
	#velocity = speed * delta * transform.x * int(toggle_move)
	velocity = speed * delta * transform.x.normalized()
	#velocity = speed * delta * Input.get_vector(
		#"ingame_move_left", "ingame_move_right", 
		#"ingame_move_up", "ingame_move_down")
	move_and_slide()
	
	kin_collision = get_last_slide_collision()
	if kin_collision != null:
		collided_with = kin_collision.get_collider()
		#if collided_with == player:
		#print(collided_with.is_in_group('enemy'))
		if collided_with.is_in_group('enemy'):
			make_collision_particles(kin_collision)
			collided_with.take_damage(1)
			self.take_damage(1)

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		die()

func die():
	var particles = $DeathParticles
	remove_child(particles)
	particles.position = position
	particles.emitting = true
	var canvas_layer = get_parent().get_tree(
		).get_first_node_in_group('outside_of_canvas_modulate')
	canvas_layer.add_child(particles)
	
	queue_free()

func make_collision_particles(kin_collision):
	var particles = $CollisionParticles
	remove_child(particles)
	particles.position = kin_collision.get_position()
	var new_normals : PackedVector2Array = particles.emission_normals
	for i in range(len(new_normals)):
		new_normals[i] = new_normals[i].rotated(PI-kin_collision.get_angle())
	particles.emission_normals = new_normals
	particles.emitting = true
	var canvas_layer = get_parent().get_tree(
		).get_first_node_in_group('outside_of_canvas_modulate')
	canvas_layer.add_child(particles)
	pass
