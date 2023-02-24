extends Area2D

func _ready():
	connect("input_event", self, "_on_Area2D_input_event")

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	var mouse_event := event as InputEventMouseButton
	if (mouse_event && mouse_event.pressed && mouse_event.button_index == BUTTON_LEFT):
		print("%s clicked" % name)
