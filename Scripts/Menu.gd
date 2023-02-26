extends Node

onready var _scene_transition : SceneTransition = $SceneTransitionColorRect

func _ready():
	pass


func _on_PlayButton_pressed():
	_scene_transition.transition_to()
