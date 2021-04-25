extends MeshInstance

export (NodePath) var le_shader
export (NodePath) var le_gdscript
export (NodePath) var spin_box_path
export (NodePath) var menu_button_path
onready var shader_path = get_node(le_shader) as LineEdit
onready var gdscript_path = get_node(le_gdscript) as LineEdit
onready var spin_box = get_node(spin_box_path) as SpinBox
onready var popup_menu = get_node(menu_button_path).get_popup() as PopupMenu

var meshes = [
	CapsuleMesh.new(),
	CubeMesh.new(),
	CylinderMesh.new(),
	PlaneMesh.new(),
	PrismMesh.new(),
	QuadMesh.new(),
	SphereMesh.new()
]

func _ready():
	popup_menu.connect("id_pressed", self, "_on_Item_pressed")
	popup_menu.add_item("CapsuleMesh")
	popup_menu.add_item("CubeMesh")
	popup_menu.add_item("CylinderMesh")
	popup_menu.add_item("PlaneMesh")
	popup_menu.add_item("PrismMesh")
	popup_menu.add_item("QuadMesh")
	popup_menu.add_item("SphereMesh")


func _process(delta):
	# rotate mesh
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
	file.close()
	
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
	file.close()
	
	# create new GDScript
	var script = GDScript.new()
	script.source_code = source
	script.reload(true)
	# add as child
	add_child(script.new())


func _on_Item_pressed(id):
	self.mesh = meshes[id]
