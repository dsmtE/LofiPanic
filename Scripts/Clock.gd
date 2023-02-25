extends Node2D

onready var audio_stream := $AudioStreamPlayer
onready var distraction := $Sprite/Node2D

export(AudioStream) var audio

var panic: bool = true

func _ready():
	# distraction.connect("clicked", self, _on_Node2D_clicked)
	pass

func panic():
	panic = true

func _process(delta):
	if panic && !audio_stream.playing:
		audio_stream.play()
	
	if !panic && audio_stream.playing:
		audio_stream.stop()

func _on_Node2D_clicked():
	panic = false
