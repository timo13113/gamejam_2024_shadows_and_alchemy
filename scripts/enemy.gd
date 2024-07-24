extends CharacterBody2D

class_name Enemy

@onready var player
#var player
@export var enemy_speed = 13000
@export var perseption_distance = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	player = get_parent().get_tree().get_first_node_in_group('player')
	#player = get_parent().get_node('Player')
	#print(player)
	#print(
		##player.get_child(0) -> CollisionShape2D
		#player.global_position
	#)
	if player != null:
		if (player.global_position - global_position).length() < perseption_distance:
			velocity = delta * enemy_speed * (
				player.global_position - global_position).normalized()
			move_and_slide()
