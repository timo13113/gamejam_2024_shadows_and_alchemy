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
	player_instance.position = $SpawnPoint.position
	self.add_child(player_instance)
	
