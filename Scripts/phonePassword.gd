extends Node2D

var hovered: bool = false
onready var buttons = [
	$Button0/Area2D,
	$Button1/Area2D,
	$Button2/Area2D,
	$Button3/Area2D,
	$Button4/Area2D,
	$Button5/Area2D,
	$Button6/Area2D,
	$Button7/Area2D,
	$Button8/Area2D]


func _ready():
	for node in buttons:
		connect("input_event", self, "_on_Area2D_input_event")
		connect("mouse_entered", self, "_on_Area2D_mouse_entered")
		connect("mouse_exited", self, "_on_Area2D_mouse_exited")

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	var mouse_event := event as InputEventMouseButton
	if (mouse_event && mouse_event.pressed && mouse_event.button_index == BUTTON_LEFT):
		print("%s clicked" % name)


func _on_Area2D_mouse_entered():
	hovered = true
	print("%s mouse_entered" % name)


func _on_Area2D_mouse_exited():
	hovered = false
	print("%s mouse_exited" % name)
