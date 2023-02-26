extends Sprite

class_name GarlandLight

signal panic_ended

onready var tween : Tween = $Tween
onready var area2D: Area2D = $Area2D

var glow_color = Color(1.5,1.3,1.2,1)

var is_in_panic: bool = false

func _ready():
	set_modulate(glow_color)
	
func start_panic():
	is_in_panic = true
	set_modulate(glow_color)

	var duration = rand_range(0.2, 0.5)
	var delay = rand_range(0.5, 1.0)

	tween.interpolate_property(self, 'modulate', Color(1.0,1.0,1.0,1), glow_color,
	duration, Tween.TRANS_BOUNCE, Tween.EASE_IN, delay)
	tween.repeat = true
	tween.start()

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT):
		if is_in_panic:
			is_in_panic = false
			tween.remove_all()
			set_modulate(glow_color)
			emit_signal("panic_ended", self)
