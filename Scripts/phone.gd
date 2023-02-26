extends Distraction

class_name Phone

# TODO : Handle sound loop from script if needed 
# (currently, loop is handled from the Import settings of the sound files)

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween
onready var sprite : Sprite = $Sprite
onready var popup_animator: AnimationPlayer = $AnimationPlayer
onready var popup = $PasswordPad

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
	popup.connect("phone_unlocked", self, "_on_phone_unlocked")
	start_panic()

func start_panic():
	.start_panic()
	audio_stream.play()
	tween.start()
	popup_animator.play("popup_appear")
	popup.poping()
	
	
func _on_phone_unlocked():
	popup_animator.play_backwards("popup_appear")
	audio_stream.stop()
	tween.stop_all()
	_end_panic()
