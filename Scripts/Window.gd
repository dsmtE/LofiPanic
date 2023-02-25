extends Dragable

onready var sprite : Sprite = $Sprite

## TODO update to take into account local sprite transform without assuming the Sprite position is (0, 0)
onready var parent_offset: Vector2 = sprite.get_parent().position
var _click_offset: Vector2 = Vector2()

func _ready():
	connect("dragging_started", self, "_dragging_started")

func tween_to_starting_state(starting_pos: Vector2, current_pos: Vector2):
	tween.interpolate_property(
			sprite,
			"position",
			null,
			Vector2(),
			0.2,
			Tween.EASE_IN,
			Tween.EASE_IN
		)
	tween.start()
	
func tween_to_current_state(starting_pos: Vector2, current_pos: Vector2):
	var target_position: Vector2 = current_pos - parent_offset + _click_offset
	tween.interpolate_property(
			sprite,
			"position",
			null,
			Vector2(sprite.position.x, target_position.y),
			0.1,
			Tween.EASE_IN
		)
	tween.start()

func _dragging_started(starting_pos: Vector2):
	_click_offset = sprite.global_position-starting_pos
