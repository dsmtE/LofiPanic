class_name Utils

static func find_by_class(node: Node, className, result : Array) -> void:
	if node is className:
		result.push_back(node)
	for child in node.get_children():
		find_by_class(child, className, result)
