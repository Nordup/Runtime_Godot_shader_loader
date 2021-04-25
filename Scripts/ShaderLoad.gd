extends MeshInstance

export (NodePath) var le_shader
export (NodePath) var le_gdscript
export (NodePath) var spin_box_path
onready var shader_path = get_node(le_shader) as LineEdit
onready var gdscript_path = get_node(le_gdscript) as LineEdit
onready var spin_box = get_node(spin_box_path) as SpinBox


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = spin_box.value
	rotate_y(speed * delta)


# CanvasLayer/Load Button
func _on_Load_button_up():
	print("------------")
	print("Loading...")
	load_Shader()
	load_GDScript()
	print("Done!")

func load_Shader():
	# read shader string
	var file = File.new()
	file.open(shader_path.text, File.READ)
	var source = file.get_as_text()
	# create new one
	var new_shader = Shader.new()
	new_shader.code = source
	# set to our material
	get_active_material(0).shader = new_shader

func load_GDScript():
	# read GDScript string
	var file = File.new()
	file.open(gdscript_path.text, File.READ)
	var source = file.get_as_text()
	# create new GDScript
	var script = GDScript.new()
	script.source_code = source
	script.reload(true)
	# add as child
	add_child(script.new())
