extends ColorRect

# Path to the next scene to transition to
export(String, FILE, "*.tscn") var next_scene_path

onready var _animation_player = $AnimationPlayer

class_name SceneTransition

func _ready():
	modulate.a = 1 # Immediately put screen to black
	_animation_player.play_backwards("Fade")

func transition_to(_next_scene := next_scene_path) -> void:
	# Plays the Fade animation and wait until it finishes
	_animation_player.play("Fade")
	yield(_animation_player, "animation_finished")
	# Changes the scene
	get_tree().change_scene(_next_scene)
