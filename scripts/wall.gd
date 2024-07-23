extends StaticBody2D

class_name Wall

#@onready var collision = $CollisionPolygon2D
#@onready var lightoccluder = $LightOccluder2D
#@onready var polygon = get_meta("polygon")
@export var polygon : PackedVector2Array
@export var toggle_sprite_invert : bool
@export var invert_border : int

#func set_shape(shape):
	#if shape == null:
		#return
	#else:
		#collision.shape = shape

# Called when the node enters the scene tree for the first time.
#func _init():
	#lightoccluder.occluder.polygon = collision.polygon

func _ready():
	var new_occl = OccluderPolygon2D.new()
	new_occl.polygon = polygon
	$LightOccluder2D.occluder = new_occl
	$CollisionPolygon2D.polygon = polygon
	$Polygon2D.polygon = polygon
	$Polygon2D.invert_enabled = toggle_sprite_invert
	$Polygon2D.invert_border = invert_border
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
