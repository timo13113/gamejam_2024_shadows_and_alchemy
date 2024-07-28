extends CharacterBody2D

class_name Enemy

@onready var player
#var player
@export var enemy_speed = 216
#@export var perseption_distance = 500
@export var hp : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_tree().get_first_node_in_group('player')
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#player.is_in_group()
	#player = get_parent().get_node('Player')
	#print(player)
	#print(
		##player.get_child(0) -> CollisionShape2D
		#player.global_position
	#)
		#print('collided:', get_last_slide_collision().get_collider())
	#print()
	if player != null:
		$RayCast2D.target_position = player.global_position - global_position
		#print($RayCast2D.get_collider())
		if (
			(player.global_position - global_position).length() < player.light_distance 
			and $RayCast2D.get_collider() == player
		):
			velocity = enemy_speed * (
				player.global_position - global_position).normalized()
			move_and_slide()
	else:
		player = get_parent().get_tree().get_first_node_in_group('player')

func take_damage(damage):
	hp -= damage
	print('enemy took damage, now has ', hp, ' hp')
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
	print("enemy died!")
	call_thread_safe('queue_free')




