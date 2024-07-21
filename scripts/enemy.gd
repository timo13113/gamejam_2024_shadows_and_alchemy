extends AnimatableBody2D

@onready var player
#var player
@export var enemy_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#player = get_parent().get_tree().get_first_node_in_group('player')
	player = get_parent().get_node('CharacterBody2D')
	#print(player)
	#print(
		##player.get_child(0) -> CollisionShape2D
		#player.global_position
	#)
	global_position += delta * enemy_speed * (
		player.global_position - global_position).normalized()
	print(global_position)
