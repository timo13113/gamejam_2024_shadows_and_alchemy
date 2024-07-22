extends Node2D

#@onready var player_node : Player
@onready var player_preload = preload("res://scenes/player.tscn")
@onready var player_instance
@onready var enemy_preload = preload("res://scenes/enemy.tscn")
@onready var enemy_instance
var t = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player_instance = player_preload.instantiate()
	print(player_instance)
	call_deferred("add_child", player_instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#t += delta
	#print(t)
	#if int(t + 1) % 2 == 0:
		#t = 0
		#call_deferred("add_child", enemy_preload.instantiate())
	pass
	
