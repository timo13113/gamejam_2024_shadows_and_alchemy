extends Area2D

class_name TargetArea

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	#if overlaps_body(Player):
		#print('overlap!!!!!!!!!!')
	for body in get_overlapping_bodies():
		if body.is_in_group('player'):
			#print('overlap!!!!!!!!!!')
			body.queue_free()
			$CPUParticles2D.emitting = true
			
	pass
