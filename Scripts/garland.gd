extends Node2D

onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
onready var tween : Tween = $Tween

onready var sprite : Sprite = $Sprite
var lights_sprites: Array = []

var panic: bool = false
var lights_panic: Array = [false, false, false, false]

var glow_color = Color(1.5,1.3,1.2,1)

func _ready():		
	randomize()
	for child in get_node("garlands/lights").get_children():
		if child is Sprite:
			child.frame = rand_range(0,3)
			lights_sprites.append(child)
	
	panic()
	
func panic():
	panic_lighs()
	start_flicker_lights()
	panic = true

func _process(delta):
	if panic && !audio_stream.playing:
		audio_stream.play()
	
	if !panic && audio_stream.playing:
		audio_stream.stop()

func panic_lighs():
	randomize()
	for i in lights_panic.size():
		lights_panic[i] = randf() > 0.5
	print_debug(lights_panic)

func start_flicker_lights():
	for i in lights_sprites.size():
		if lights_panic[i]:
			flicker_light(lights_sprites[i])
		
func flicker_light(light: Sprite):
	light.set_modulate(glow_color)
	
	var duration = rand_range(0.2, 0.5)
	var delay = rand_range(1.0, 2.0)
	
	tween.interpolate_property(light, 'modulate', glow_color, Color(1.0,1.0,1.0,1),
	duration, Tween.TRANS_BOUNCE, Tween.EASE_IN, delay)
	tween.repeat = true
	tween.start()
	
func _on_Node2D_input_event(viewport, event, shape_idx):
	var mouse_event := event as InputEventMouseButton
	if (mouse_event && mouse_event.pressed && mouse_event.button_index == BUTTON_LEFT):
		stop_light(shape_idx)

func _on_Tween_tween_completed(object, key):
	var id = lights_sprites.find(object)
	if lights_panic[id]: 
		flicker_light(object)

func stop_light(id: int):
	lights_panic[id] = false
	update_panic()
	tween.reset(lights_sprites[id])
	
func update_panic():
	panic = false
	for light_panic in lights_panic:
		panic = panic || light_panic
	print("panic: ", panic)
