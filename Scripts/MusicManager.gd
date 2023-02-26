extends AudioStreamPlayer

onready var _tween : Tween = $Tween

func _ready():
	volume_db = -80

func play_music():
	_tween.disconnect("tween_completed", self, "_on_tween_finished")
	_tween.interpolate_property(self, 
		"volume_db", -80, 0, 2, Tween.TRANS_SINE, Tween.EASE_IN, 0)
		
	_tween.start()
	play()
	

func stop_music():
	_tween.connect("tween_completed", self, "_on_tween_finished")
	_tween.interpolate_property(self, 
		"volume_db", 0, -80, 2, Tween.TRANS_SINE, Tween.EASE_IN, 0)
		
	_tween.start()
	
func _on_tween_finished():
	stop()
