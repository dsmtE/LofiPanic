extends Node2D

signal phone_unlocked

var active: bool = false
var dragging: bool = false
export var unlock_sequence: Array = [0, 1, 2, 5, 4, 3, 6]
onready var buttons: Array = [
	$Buttons/Button0/Area2D0,
	$Buttons/Button1/Area2D1,
	$Buttons/Button2/Area2D2,
	$Buttons/Button3/Area2D3,
	$Buttons/Button4/Area2D4,
	$Buttons/Button5/Area2D5,
	$Buttons/Button6/Area2D6,
	$Buttons/Button7/Area2D7,
	$Buttons/Button8/Area2D8]

onready var line: Line2D = $Line2D

var last_button: int = -1
var sequence: Array = []

func poping():
	line.clear_points()
	for i in buttons.size():
		buttons[i].connect("button_clicked", self, "_on_mouse_click")
		buttons[i].connect("button_overed", self, "_on_mouse_entered")

func unpop():
	for i in buttons.size():
		buttons[i].disconnect("button_clicked", self, "_on_mouse_click")
		buttons[i].disconnect("button_overed", self, "_on_mouse_entered")

func _on_mouse_click(button: Node):
	last_button = buttons.find(button)
	sequence.append(last_button)
	line.add_point(button.get_parent().position)
	line.add_point(button.get_parent().position)
	dragging = true

func _on_mouse_entered(button: Node):
	last_button = button.name[6] as int
	if dragging && !sequence.has(last_button):
		sequence.append(last_button)
		line.add_point(button.get_parent().position, line.points.size()-1)
		print_debug(sequence)
		if sequence == unlock_sequence:
			unlocked()


func _on_Area2D_mouse_exited():
#	hovered = false
	print("%i mouse_exited" % name)


func _input(event: InputEvent):
	if event is InputEventMouseButton and !event.is_pressed() && event.button_index == BUTTON_LEFT:
		dragging = false
		if sequence != unlock_sequence:
			sequence.clear()
			line.clear_points()
			last_button = -1
	
	if dragging && event is InputEventMouseMotion:
		line.set_point_position(line.points.size()-1, (event.position-global_position)/global_scale)

func unlocked():
	line.remove_point(line.get_point_count()-1)
	dragging = false
	unpop()
	emit_signal("phone_unlocked")
