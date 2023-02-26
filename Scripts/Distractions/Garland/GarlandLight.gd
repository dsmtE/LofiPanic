extends Sprite

class_name GarlandLight

signal panic_ended

onready var tween : Tween = $Tween
onready var area2D: Area2D = $Area2D

var is_in_panic: bool = false

func _ready():
	area2D.connect("input_event", self, "_on_Area2D_input_event")
	randomize()
	toggle_light(true)

func generate_tween_flickering():
	for i in 20:
		tween.interpolate_callback(self, rand_range(0.1, 0.3), "toggle_light", i%2 == 0)
	tween.repeat = true

func toggle_light(state: bool):
	if state:
		frame = 0
		var intensity = rand_range(1.1, 1.3)
		set_modulate(Color(intensity, intensity, intensity, 1))
	else:
		frame = 1
		set_modulate(Color.white)
	
func start_panic():
	is_in_panic = true
	generate_tween_flickering()
	tween.start()

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT):
		if is_in_panic:
			is_in_panic = false
			tween.remove_all()
			toggle_light(true)
			emit_signal("panic_ended", self)
