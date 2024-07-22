extends StaticBody2D

@onready var collision = $CollisionPolygon2D
@onready var lightoccluder = $LightOccluder2D

#func set_shape(shape):
	#if shape == null:
		#return
	#else:
		#collision.shape = shape

# Called when the node enters the scene tree for the first time.
#func _init():
	#lightoccluder.occluder.polygon = collision.polygon

func _ready():
	#children = get_children()
	#print($CollisionShape2D)
	#print($CollisionShape2D)
	#print(lightoccluder)
	#print(collision.polygon)
	#print(lightoccluder.occluder)
	#lightoccluder.occluder = collision.polygon
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
