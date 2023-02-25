extends Node

class_name GameManager


var _distractions: Array = []

func _ready():
	find_by_class(self, Distraction, _distractions)
	print(_distractions)

static func find_by_class(node: Node, className, result : Array) -> void:
	if node is className:
		result.push_back(node)
	for child in node.get_children():
		find_by_class(child, className, result)
