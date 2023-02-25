extends Distraction

class_name Clock

# TODO : Handle sound loop from script if needed 
# (currently, loop is handled from the Import settings of the sound files)

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween
onready var sprite : Sprite = $Sprite

export var shake: float = 4
export var shake_duration_center: float = 0.05
export var shake_duration_amp: float = 0.01
export var shake_count: float = 15

func _ready():	
	for i in shake_count:
		tween.interpolate_property(
			sprite,
			"position",
			null,
			Vector2(rand_range(-shake, shake),
			rand_range(-shake, shake)),
			rand_range(shake_duration_center-shake_duration_amp, shake_duration_center+shake_duration_amp)
		)
	tween.repeat = true

func _process(_delta):
	# TODO : 
	pass

func start_panic():
	.start_panic()
	audio_stream.play()
	tween.start()
	
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	var mouse_event := event as InputEventMouseButton
	if (mouse_event && mouse_event.pressed && mouse_event.button_index == BUTTON_LEFT):
		audio_stream.stop()
		tween.stop_all()
		_end_panic()
