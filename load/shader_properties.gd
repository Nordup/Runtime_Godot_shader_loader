extends Node

var parent : MeshInstance

func _ready():
	parent = get_parent()
	
func _process(delta):
	var mat = parent.get_active_material(0) as ShaderMaterial
	var noise = NoiseTexture.new()
	mat.set_shader_param("outline_noise_tex", noise)
	mat.set_shader_param("outline_color", Color(1, 0, 1, 1))
