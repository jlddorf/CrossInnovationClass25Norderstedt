extends MeshInstance3D

func _ready() -> void:
	var map_mesh : PlaneMesh = mesh
	var material : StandardMaterial3D = map_mesh.material
	var texture_aspect : float = material.albedo_texture.get_size().aspect()
	var mesh_size : Vector2 = map_mesh.size
	mesh.size.x = mesh_size.y * texture_aspect
