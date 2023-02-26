extends Distraction

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween

onready var off_sprite: Sprite = $OrdiOff
onready var on_sprite: Sprite = $OrdiOn
onready var fx: Sprite = $FxOrdi
onready var hint_sprite: Hint = $Hint

func _ready():
	randomize()
	toggle_light(false)
	
func generate_tween_flickering():
	for i in 20:
		tween.interpolate_callback(self, rand_range(0.1, 0.3), "toggle_light", i%2 == 0)
	tween.repeat = true
	
func toggle_light(state: bool):
	if state:
		on_sprite.visible = true
		off_sprite.visible = false
		fx.visible = true
	else:
		on_sprite.visible = false
		off_sprite.visible = true
		fx.visible = false
		
func start_panic():
	.start_panic()
	hint_sprite.start_panic()
	audio_stream.play()
	generate_tween_flickering()
	tween.start()
	
func _end_panic():
	._end_panic()
	hint_sprite.end_panic()
	toggle_light(false)
	audio_stream.stop()
	tween.stop_all()

func _on_Area2D_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT :
		_end_panic()
