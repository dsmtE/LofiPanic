extends Distraction

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween

onready var off_sprite: Sprite = $Off
onready var on_sprite: Sprite = $On

func _ready():
	randomize()
	# TODO change using spriteSheet if possible
	on_sprite.visible = false
	off_sprite.visible = true
	
	generate_tween_flickering()
	
func generate_tween_flickering():
	for i in 20:
		tween.interpolate_callback(self, rand_range(0.1, 0.3), "toggle_light")
	tween.repeat = true
	
func toggle_light():
	on_sprite.visible = !on_sprite.visible
	off_sprite.visible = !off_sprite.visible

func start_panic():
	.start_panic()
	audio_stream.play()
	generate_tween_flickering()
	tween.start()
	
func _end_panic():
	on_sprite.visible = false
	off_sprite.visible = true
	._end_panic()

func _on_Area2D_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT :
		audio_stream.stop()
		tween.stop_all()
		_end_panic()
