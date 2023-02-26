extends Distraction

class_name Phone

# TODO : Handle sound loop from script if needed 
# (currently, loop is handled from the Import settings of the sound files)

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween
onready var on_sprite : Sprite = $OnSprite
onready var off_sprite : Sprite = $OffSprite
onready var popup_animator: AnimationPlayer = $AnimationPlayer
onready var popup = $PasswordPad

export var shake: float = 4
export var shake_duration_center: float = 0.05
export var shake_duration_amp: float = 0.01
export var shake_count: float = 15

func _ready():
	on_sprite.visible = false
	off_sprite.visible = true
	
	for i in shake_count:
		tween.interpolate_property(
			on_sprite,
			"position",
			null,
			Vector2(rand_range(-shake, shake),
			rand_range(-shake, shake)),
			rand_range(shake_duration_center-shake_duration_amp, shake_duration_center+shake_duration_amp)
		)
	tween.repeat = true
	popup.connect("phone_unlocked", self, "_on_phone_unlocked")

func start_panic():
	.start_panic()
	on_sprite.visible = true
	off_sprite.visible = false
	audio_stream.play()
	tween.start()
	popup_animator.play("popup_appear")
	popup.poping()

func _end_panic():
	._end_panic()
	on_sprite.visible = false
	off_sprite.visible = true
	popup_animator.play_backwards("popup_appear")
	audio_stream.stop()
	tween.stop_all()
	
func _on_phone_unlocked():
	_end_panic()
