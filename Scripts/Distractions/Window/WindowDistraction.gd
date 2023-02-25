extends Distraction

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var window: Node2D = $WindowDragable/Window
onready var tween: Tween = $WindowDragable/Tween
onready var windowDragable: Dragable = $WindowDragable

export(Vector2) var open_position
export(float) var open_rotation

var closed_position: Vector2
var closed_rotation: float

# Assume the window is position closed by default
func _ready():
	closed_position = window.position
	closed_rotation = window.rotation
	
func start_panic():
	.start_panic()
	windowDragable.draggable = true
	tween.interpolate_property(window, 'position', null, open_position,
		0.4, Tween.EASE_OUT, Tween.EASE_OUT, 0.1)
	tween.interpolate_property(window, 'rotation_degrees', null, open_rotation,
		0.4, Tween.EASE_OUT, Tween.EASE_OUT, 0.1)
	tween.start()
	
	audio_stream.play()

func _end_panic():
	._end_panic()
	windowDragable.draggable = false
	audio_stream.stop()
	tween.interpolate_property(window, 'position', null, closed_position,
		0.4, Tween.EASE_OUT, Tween.EASE_OUT, 0.1)
	tween.interpolate_property(window, 'rotation_degrees', null, closed_rotation,
		0.4, Tween.EASE_OUT, Tween.EASE_OUT, 0.1)

	tween.start()
	
func _on_WindowDragable_target_reached():
	print("_on_WindowDragable_target_reached")
	_end_panic()
