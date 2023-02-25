extends Node2D

signal panic_ended

# Distraction
class_name Distraction

export(int) var level = 0

var is_in_panic: bool = false setget, is_in_panic_get

func start_panic():
	is_in_panic = true
	
func _end_panic():
	is_in_panic = false
	emit_signal("panic_ended", self)

func is_in_panic_get() -> bool :
	return is_in_panic
	

func _ready():
	pass
