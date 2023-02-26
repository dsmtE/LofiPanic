extends AudioStreamPlayer

onready var _tween : Tween = $Tween

var _is_playing = false

func _ready():
	volume_db = -80
	
	play_music()

func play_music():
	if _is_playing:
		return
	
	if (_tween.is_connected("tween_completed", self, "_on_tween_finished")):
		_tween.disconnect("tween_completed", self, "_on_tween_finished")
		
	_tween.interpolate_property(self, 
		"volume_db", -30, 0, 1, Tween.TRANS_SINE, Tween.EASE_IN, 0)
		
	_tween.start()
	play()
	
	_is_playing = true
	

func stop_music():
	_tween.connect("tween_completed", self, "_on_tween_finished")
	_tween.interpolate_property(self, 
		"volume_db", 0, -80, 2, Tween.TRANS_SINE, Tween.EASE_IN, 0)
		
	_tween.start()
	
	_is_playing = false
	
	
func _on_tween_finished():
	stop()
