extends Distraction

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween
onready var LightsContainer := $lightsContainer

var lights: Array = []

func _ready():
	randomize()
	Utils.find_by_class(LightsContainer, GarlandLight, lights)
	for light in lights:
		light.connect("panic_ended", self, "_end_panic_light")
		
	start_panic()
	
func start_panic():
	.start_panic()
	audio_stream.play()
	
	for light in lights:
		if randf() > 0.1:
			light.start_panic()

func _end_panic():
	audio_stream.stop()
	._end_panic()

func _end_panic_light(light: GarlandLight):
	if !_compute_global_panic():
		_end_panic()

func _compute_global_panic():
	var panic: bool = false
	for light in lights:
		panic = panic || light.is_in_panic
	return panic
