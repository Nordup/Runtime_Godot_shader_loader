extends Spatial

const speed = -0.005
var rotate = false

	
func _unhandled_input(event):
	if event is InputEventMouseMotion and rotate:
		var movement = event.relative
		rotate_object_local(Vector3.UP, movement.x * speed)
		rotate_object_local(Vector3.RIGHT, movement.y * speed)
		# correct
		rotation.x = clamp(rotation.x, deg2rad(-80), deg2rad(80))
		rotation.z = 0
		
func _process(delta):
	if (Input.is_action_pressed("Click")):
		rotate = true
	else:
		rotate = false
