class_name Utils

static func find_by_class(node: Node, className, result : Array) -> void:
	if node is className:
		result.push_back(node)
	for child in node.get_children():
		find_by_class(child, className, result)

static func phyllotaxis_point(n: int, base: float = 1) -> Vector2:
	var base_angle = PI*(1+sqrt(5))*base
	var r = sqrt(n)
	var theta = n*base_angle
	return Vector2(r*cos(theta), r*sin(theta))
