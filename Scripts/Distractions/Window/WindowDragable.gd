extends Dragable

onready var sprite : Sprite = $Window

onready var sprite_parent: Node2D = sprite.get_parent()

var _start_dragging_local_offset: Vector2 = Vector2()
var _starting_local_position: Vector2

func _ready():
	connect("dragging_started", self, "_dragging_started")

func tween_to_starting_state(_starting_pos: Vector2, _current_pos: Vector2):
	tween.interpolate_property(
			sprite,
			"position",
			null,
			_starting_local_position,
			0.2,
			Tween.EASE_IN,
			Tween.EASE_IN
		)
	tween.start()

func tween_to_current_state(_starting_mouse_pos: Vector2, current_mouse_pos: Vector2):
	
	var local_mouse_pos: Vector2 = sprite_parent.to_local(current_mouse_pos)
	var target_position: Vector2 = local_mouse_pos + _start_dragging_local_offset
	
	tween.interpolate_property(
			sprite,
			"position",
			null,
			Vector2(sprite.position.x, target_position.y),
			0.1,
			Tween.EASE_IN
		)
	tween.start()

func dragging_started(mouse_pos: Vector2):
	var local_mouse_pos: Vector2 = sprite_parent.to_local(mouse_pos)
	_starting_local_position = sprite.position
	_start_dragging_local_offset = sprite.position-local_mouse_pos
