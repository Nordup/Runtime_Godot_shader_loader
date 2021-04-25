extends Spatial

const speed = -0.005
const wheel_speed = 0.1
onready var camera = get_child(0) as Spatial

var rotate = false


func _unhandled_input(event):
	if event is InputEventMouseMotion and rotate:
		var movement = event.relative
		rotate_object_local(Vector3.UP, movement.x * speed)
		rotate_object_local(Vector3.RIGHT, movement.y * speed)
		# correct
		rotation.x = clamp(rotation.x, deg2rad(-80), deg2rad(80))
		rotation.z = 0


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_WHEEL_UP:
			camera.translate(-camera.translation * wheel_speed)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			camera.translate(camera.translation * wheel_speed)
		camera.translation.z = clamp(camera.translation.z , 1.8, 100)


func _process(delta):
	if (Input.is_action_pressed("Click")):
		rotate = true
	else:
		rotate = false
