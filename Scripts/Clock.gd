extends Node2D

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var distraction : Node2D = $Sprite/Node2D
onready var tween : Tween = $Tween
onready var sprite : Sprite = $Sprite

var panic: bool = true

export var shake: float = 4
export var shake_duration_center: float = 0.05
export var shake_duration_amp: float = 0.01
export var shake_count: float = 15

func _ready():
	# distraction.connect("clicked", self, _on_Node2D_clicked)
	
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
	
func panic():
	panic = true

func _process(delta):
	if panic && !audio_stream.playing:
		audio_stream.play()
		tween.start()
	
	if !panic && audio_stream.playing:
		audio_stream.stop()
		tween.stop_all()
		

func _on_Node2D_clicked():
	panic = false

