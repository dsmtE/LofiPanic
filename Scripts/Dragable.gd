extends Node2D

class_name Dragable

signal dragging_started

onready var tween : Tween = $Tween

export(String) var area2D_node_path
export(String) var source_collision_node_path
export(String) var target_collision_node_path

onready var area2D: Area2D = get_node(area2D_node_path)
onready var source_collision_shape: Node2D = get_node(area2D_node_path + "/" + source_collision_node_path)
onready var target_collision_shape: Node2D = get_node(area2D_node_path + "/" + target_collision_node_path)

var dragging: bool = false
var starting_drag_pos: Vector2 = Vector2()
var current_drag_pos: Vector2 = Vector2()

func _ready():
	set_process_input(true)
	area2D.connect("input_event", self, "_area2D_input_event")
	# area2D.connect("area_shape_entered", self, "_on_Area2D_area_shape_entered")
	pass

func _area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int):

	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		if shape_idx == source_collision_shape.get_index():
			starting_drag_pos = get_global_mouse_position()
			current_drag_pos = starting_drag_pos
			dragging = true
			emit_signal("dragging_started", starting_drag_pos)

func tween_to_starting_state(starting_pos: Vector2, current_pos: Vector2):
	pass
	
func tween_to_current_state(starting_pos: Vector2, current_pos: Vector2):
	pass

func _input(event: InputEvent):
	if !dragging: return
	
	if event is InputEventMouseMotion:
		current_drag_pos = get_global_mouse_position()
		tween_to_current_state(starting_drag_pos, current_drag_pos)
		
	if event is InputEventMouseButton and !event.is_pressed() && event.button_index == BUTTON_LEFT:
		print("dragging out")
		dragging = false
		tween_to_starting_state(starting_drag_pos, current_drag_pos)
	
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("area_shape_entered: %d" % local_shape_index)
