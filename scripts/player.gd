extends CharacterBody2D

class_name Player

@export var hp : int = 1
@export var damp_wiggle_threshold = 0.0003
@export var speed_default = 250
@export var speed_strong = 150
@export var speed_weak = 350
@export var light_distance_default = 500
@export var light_distance_strong = 1000
@export var light_distance_weak = 250
var speed = speed_default
var light_distance = light_distance_default
var toggle_move = false
var toggle_strong_light = false
var toggle_weak_light = false
var kin_collision : KinematicCollision2D
var collided_with : Node2D

func _input(event):
	#if event.is_action_pressed("toggle_move"):
		#toggle_move = true
	#if event.is_action_released("toggle_move"):
		#toggle_move = false
	if event.is_action_pressed("toggle_strong_light"):
		toggle_strong_light = true
		alter_light()
	if event.is_action_released("toggle_strong_light"):
		toggle_strong_light = false
		alter_light()
	if event.is_action_pressed("toggle_weak_light"):
		toggle_weak_light = true
		alter_light()
	if event.is_action_released("toggle_weak_light"):
		toggle_weak_light = false
		alter_light()
	
func alter_light():
	if toggle_strong_light and not toggle_weak_light:
		light_distance = 1000
		speed = speed_strong
		$Light.texture_scale = 2
		#print('strong')
	elif toggle_weak_light and not toggle_strong_light:
		light_distance = 250
		speed = speed_weak
		$Light.texture_scale = 0.5
		#print('weak')
	else:
		light_distance = light_distance_default
		speed = speed_default
		$Light.texture_scale = 1
		#print('default')
	
		#var new_light : Texture2D = $Light.texture
		#new_light.width = 4000
		#new_light.height = 4000
		#$Light.texture = new_light
	print('light update')

var logging_delta = 0.5
var t = 0

func _process(delta):
	t += delta
	if t > logging_delta:
		print('FPS:', Engine.get_frames_per_second())
		t = 0
	

func _physics_process(delta):
	#* int(toggle_move)
	if speed * delta > (position - get_global_mouse_position()).length():
		velocity = (get_global_mouse_position() - global_position) / delta
	else:
		velocity = speed * (get_global_mouse_position() - global_position).normalized()
	#velocity = speed * delta * Input.get_vector(
		#"ingame_move_left", "ingame_move_right", 
		#"ingame_move_up", "ingame_move_down")
	
	#for collision in range(get_slide_collision_count()):
		#print('collision detected: ', collision)
	
	var has_collided_this_frame = []
	for collision in range(get_slide_collision_count()):
		kin_collision = get_slide_collision(collision)
		collided_with = kin_collision.get_collider()
		#print("collided with: ", collided_with)
		
		# FIXME: idk, but collisions linger for 1 more frame, this fixes it
		# might become a problem with multihit/segmeted enemies
		if not (collided_with != null):
			continue
		
		# FIXME: fix for possible double collisions, seems fine for now
		if collided_with in has_collided_this_frame:
			continue
		has_collided_this_frame.push_back(collided_with)
		
		var correction = - velocity.normalized().dot(kin_collision.get_normal())
		#print(
			##(kin_collision.get_position() - global_position).normalized(),
			##kin_collision.get_normal(),
			#kin_collision.get_normal().dot((kin_collision.get_position() - global_position).normalized()),
			#velocity.normalized(),
			#velocity.normalized().dot((kin_collision.get_position() - global_position).normalized())
		#)
		#print(collision, '\t', correction, '\t', kin_collision.get_collider())
		if absf(correction - 1) < damp_wiggle_threshold:
			velocity *= 0 # stop player from wobbling in place if running at the wall
		
		if collided_with.is_in_group('enemy'):
			#make_collision_particles(kin_collision)
			var has_killed = collided_with.take_damage(1)
			var has_died = self.take_damage(1)
			if has_died:
				break
	move_and_slide()
	#print('###player frame ended')

func take_damage(damage):
	hp -= damage
	print('player took damage, now has ', hp, ' hp')
	if hp <= 0:
		die()
		return true
	return false

func die():
	var particles = $DeathParticles
	remove_child(particles)
	particles.position = position
	particles.emitting = true
	var canvas_layer = get_parent().get_tree(
		).get_first_node_in_group('outside_of_canvas_modulate')
	canvas_layer.add_child(particles)
	$CollisionShape2D.disabled = true
	queue_free()

#func make_collision_particles(kin_collision):
	##print('making collision particles')
	#var particles = $CollisionParticles
	##remove_child(particles)
	#particles.position = kin_collision.get_position()
	#var new_normals : PackedVector2Array = particles.emission_normals
	#for i in range(len(new_normals)):
		#new_normals[i] = new_normals[i].rotated(PI-kin_collision.get_angle())
	#particles.emission_normals = new_normals
	#particles.emitting = true
	#var canvas_layer = get_parent().get_tree(
		#).get_first_node_in_group('outside_of_canvas_modulate')
	#canvas_layer.add_child(particles)
	##print('made collision particles!')
	#
	#pass
