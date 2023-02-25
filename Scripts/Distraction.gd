extends Node2D

# TODO : remove any particular implementation from Distraction class
# Only keep here management of "panic mode"
#signal clicked

signal panic_ended

# Distraction
class_name Distraction

var hovered: bool = false # TODO : move to custom class

var is_in_panic: bool = false setget, is_in_panic_get

func start_panic():
	is_in_panic = true
	
func _end_panic():
	is_in_panic = false
	emit_signal("panic_ended", self)

func is_in_panic_get() -> bool :
	return is_in_panic
	

func _ready():
	pass
	
#	# TODO : move to custom class
#	connect("input_event", self, "_on_Area2D_input_event")
#	connect("mouse_entered", self, "_on_Area2D_mouse_entered")
#	connect("mouse_exited", self, "_on_Area2D_mouse_exited")


## TODO : move to custom class everything below
#func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int):
#	var mouse_event := event as InputEventMouseButton
#	if (mouse_event && mouse_event.pressed && mouse_event.button_index == BUTTON_LEFT):
#		print("%s clicked" % name)
#		emit_signal("clicked")
#
#func _on_Area2D_mouse_entered():
#	hovered = true
#	print("%s mouse_entered" % name)
#
#func _on_Area2D_mouse_exited():
#	hovered = false
#	print("%s mouse_exited" % name)
