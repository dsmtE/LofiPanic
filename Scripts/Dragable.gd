extends Node2D

class_name Dragable

signal dragging_started
signal target_reached

onready var tween : Tween = $Tween

export(String) var source_area2D_node_path
export(String) var target_area2D_node_path

onready var source_area2D_shape: Area2D = get_node(source_area2D_node_path)
onready var target_area2D_shape: Area2D = get_node(target_area2D_node_path)

var dragging: bool = false
var starting_drag_pos: Vector2 = Vector2()
var current_drag_pos: Vector2 = Vector2()

func _ready():
	set_process_input(true)
	source_area2D_shape.connect("input_event", self, "_on_source_area2D_input_event")
	target_area2D_shape.connect("mouse_entered", self, "_on_target_area_mouse_entered")
	pass

func _on_source_area2D_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		starting_drag_pos = get_global_mouse_position()
		dragging = true
		dragging_started(starting_drag_pos)

func tween_to_starting_state(_starting_pos: Vector2, _current_mouse_pos: Vector2):
	pass
	
func tween_to_current_state(_starting_pos: Vector2, _current_mouse_pos: Vector2):
	pass
	
func dragging_started(_current_mouse_pos: Vector2):
	pass

func _input(event: InputEvent):
	if !dragging: return
	
	if event is InputEventMouseMotion:
		current_drag_pos = get_global_mouse_position()
		tween_to_current_state(starting_drag_pos, current_drag_pos)
		
	if event is InputEventMouseButton and !event.is_pressed() && event.button_index == BUTTON_LEFT:
		dragging = false
		tween_to_starting_state(starting_drag_pos, current_drag_pos)
	
func _on_target_area_mouse_entered():
	if dragging:
		dragging = false
		tween_to_starting_state(starting_drag_pos, current_drag_pos)
		emit_signal("target_reached")
