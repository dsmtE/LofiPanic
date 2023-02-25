extends Node

class_name GameManager

var _distractions: Array = []

func _ready():
	find_by_class(self, Distraction, _distractions)	
	print(_distractions)
	
	for distraction in _distractions:
		distraction.start_panic()
		distraction.connect("panic_ended", self, "_on_distraction_panic_ended")

func _on_distraction_panic_ended(node):
	print("Distraction %s ended" % node.name)

static func find_by_class(node: Node, className, result : Array) -> void:
	if node is className:
		result.push_back(node)
	for child in node.get_children():
		find_by_class(child, className, result)
