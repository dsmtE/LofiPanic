extends Node2D

var dragging: bool = false
export var unlock_sequence: Array = [1, 4, 5, 8]
onready var pos := global_position
onready var buttons: Array = [
	$Button0/Area2D0,
	$Button1/Area2D1,
	$Button2/Area2D2,
	$Button3/Area2D3,
	$Button4/Area2D4,
	$Button5/Area2D5,
	$Button6/Area2D6,
	$Button7/Area2D7,
	$Button8/Area2D8]

onready var line: Line2D = $Line2D

var last_button: int = -1
var sequence: Array = []

func _ready():
	line.clear_points()
	for i in buttons.size():
		buttons[i].connect("button_clicked", self, "_on_mouse_click")
		buttons[i].connect("button_overed", self, "_on_mouse_entered")

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
		line.set_point_position(line.points.size()-1, event.position-pos)

func unlocked():
	line.remove_point(line.get_point_count()-1)
	dragging = false
	print("you win")
