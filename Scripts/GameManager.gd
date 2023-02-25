extends Node

class_name GameManager

var _distractions: Array = []

func _ready():
	Utils.find_by_class(self, Distraction, _distractions)	
	print(_distractions)
	
	for distraction in _distractions:
		distraction.start_panic()
		distraction.connect("panic_ended", self, "_on_distraction_panic_ended")

func _on_distraction_panic_ended(node):
	print("Distraction %s ended" % node.name)
