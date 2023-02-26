extends Node

onready var _scene_transition : SceneTransition = $SceneTransitionColorRect

func _on_AnimationPlayer_animation_finished(anim_name):
	_scene_transition.transition_to()
