extends Control

onready var _scene_transition: SceneTransition = $SceneTransitionColorRect

func _ready():
	pass


func _on_RestartButton_pressed():
	_scene_transition.transition_to()
