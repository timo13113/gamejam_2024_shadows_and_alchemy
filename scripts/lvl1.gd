extends Node2D

#@onready var player_node : Player
@onready var player_preload = preload("res://scenes/player.tscn")
@onready var player_instance
@onready var enemy_preload = preload("res://scenes/enemy.tscn")
@onready var enemy_instance
@onready var wall_preload = preload("res://scenes/wall.tscn")
@onready var wall_instance : Wall
var t = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player_instance = player_preload.instantiate()
	#print(player_instance)
	player_instance.position = $SpawnPoint.position
	self.add_child(player_instance)
	#call_deferred("add_child", player_instance)
	#wall_instance = wall_preload.instantiate()
	#call_deferred("add_child", wall_instance)
	#self.add_child(wall_instance)
	#print(wall_instance.())
	#$Wall.position
	#print(get_tree_string_pretty())
	#$Wall.position = Vector2(100, 100)
	#$Wall.polygon = PackedVector2Array([])
	#$Wall
	#get_
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
	#t += delta
	#print(t)
	#if int(t + 1) % 2 == 0:
		#t = 0
		#call_deferred("add_child", enemy_preload.instantiate())
	#pass
	
