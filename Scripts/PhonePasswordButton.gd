extends Area2D

signal button_clicked
signal button_overed

func _ready():
	connect("input_event", self, "_on_input_event")
	connect("mouse_entered", self, "_on_mouse_entered")



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	var mouse_event := event as InputEventMouseButton
	if (mouse_event && mouse_event.pressed && mouse_event.button_index == BUTTON_LEFT):
		emit_signal("button_clicked", self)

func _on_mouse_entered():
	emit_signal("button_overed", self)
