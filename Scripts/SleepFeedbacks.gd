extends Node

onready var _temp_progress_bar: ProgressBar = $ProgressBar
onready var bubbles_container: Node2D = $BubblesContainer

class_name SleepFeedbacks

var sleep_health : float setget sleep_health_set

var bubbles: Array = []

export(int) var wanted_bubble_count = 10

func _ready():
	sleep_health_set(100)
	var bubble_scene = load("res://Scenes/Bubble.tscn")
	
	for i in wanted_bubble_count:
		var f: float = 1.0 - (i as float +1.0)/ wanted_bubble_count as float
		var bubble = bubble_scene.instance()
		var scale_factor = rand_range(0.3*f+0.7, 1.0)*0.7
		bubble.scale = Vector2(scale_factor, scale_factor)
		bubble.position = Utils.phyllotaxis_point(i) * 10
		bubble.pop_threshold = i as float / wanted_bubble_count as float
		bubbles_container.add_child(bubble)
		bubbles.append(bubbles)
	
func sleep_health_set(new_value : float):
	sleep_health = new_value
	_update_feedbacks()	

func _update_feedbacks():
	# TEMP VIA UI
	_temp_progress_bar.value = sleep_health
	
	for bubble in bubbles_container.get_children():
		bubble.update_feedback(sleep_health / 100.0)

