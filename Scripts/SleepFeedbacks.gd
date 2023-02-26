extends Node

onready var _temp_progress_bar: ProgressBar = $ProgressBar

class_name SleepFeedbacks

var sleep_health : float setget sleep_health_set

func sleep_health_set(new_value : float):
	sleep_health = new_value
	_update_feedbacks()

func _update_feedbacks():
	# TEMP VIA UI
	_temp_progress_bar.value = sleep_health

func _ready():
	sleep_health_set(100)

