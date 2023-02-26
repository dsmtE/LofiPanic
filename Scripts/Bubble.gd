extends Node2D

onready var tween : Tween = $Tween
onready var pop_timer: Timer = $Timer
var starting_position: Vector2

var alive: bool = true
var pop_threshold: float

func _ready():
	randomize()
	starting_position = position
	generate_tween_position()
	tween.start()
	pop_timer.connect("timeout", self, "end_pop")

func update_feedback(value: float):
	if !alive: return
	
	if pop_threshold > value :
		_pop_bubble()
	
func _pop_bubble():
	tween.interpolate_property(
			self,
			"scale",
			null,
			Vector2(0, 0),
			0.8
		)
	pop_timer.wait_time = 0.8
	pop_timer.start()
	alive = false
	
func end_pop():
	queue_free()

func generate_tween_position():
	var floating_jitter: Array = []
	var amp = 1
	
	for i in 20:
		floating_jitter.append(Vector2(rand_range(-amp, amp), rand_range(-amp, amp)))
	
	var size = floating_jitter.size()
	var duration = rand_range(0.5, 0.9)
	for i in size:
		tween.interpolate_property(
			self,
			"position",
			starting_position + floating_jitter[(i-1+size) % size],
			starting_position + floating_jitter[i],
			duration,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN_OUT,
			duration*i
		)
	tween.repeat = true
