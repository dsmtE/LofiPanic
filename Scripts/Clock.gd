extends Distraction

class_name Clock

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween
onready var sprite : Sprite = $Sprite
onready var hours_sprite : Sprite = $Sprite/Hours
onready var hint_sprite: Hint = $Hint

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

func increment_hour():
	hours_sprite.frame += 2

func start_panic():
	.start_panic()
	audio_stream.play()
	tween.start()
	hint_sprite.start_panic()

func _end_panic():
	._end_panic()
	hint_sprite.end_panic()
	audio_stream.stop()
	tween.stop_all()
		
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT):
		_end_panic()
