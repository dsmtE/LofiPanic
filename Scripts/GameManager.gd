extends Node

class_name GameManager

export(float) var _min_distraction_wait_time = 2.0
export(float) var _max_distraction_wait_time = 5.0

export(String, FILE, "*.tscn") var _win_scene_path
export(String, FILE, "*.tscn") var _lose_scene_path

onready var _level_timer: Timer = $"%LevelTimer"
onready var _new_distraction_trigger_timer: Timer = $"%NewDistractionTriggerTimer"

onready var _sleep_feedbacks: SleepFeedbacks = $"%SleepFeedbacks"

onready var _scene_transition: SceneTransition = $"%SceneTransitionColorRect"

var _distractions_per_level: Array = []

# Contains all distractions of level 0 when player is at level 0,
# all distractions of level 0 + 1 when player is at level 1, etc...
var _current_pool_of_distractions: Array = []

var _distractions_in_panic: Array = []

var _current_level = 0
var _highest_level = 0

var _sleep_health : float = 100.0

func _ready():
	var distractions: Array = []
	Utils.find_by_class(self, Distraction, distractions)
	
	_highest_level = _find_highest_distraction_level(distractions)
	_distractions_per_level.resize(_highest_level + 1)
	for i in range(0, _highest_level + 1):
		_distractions_per_level[i] = []
	
	for distraction in distractions:
		distraction = distraction as Distraction
		distraction.connect("panic_ended", self, "_on_distraction_panic_ended")
		
		print_debug("Distraction %s level : %d" % [distraction.name, distraction.level])
		
		_distractions_per_level[distraction.level].append(distraction)
		
	print_debug(_distractions_per_level)
	_start_game()


func _start_game():
	_sleep_health = 100.0
	_sleep_feedbacks.sleep_health = 100.0
	
	_current_level = 0
	_current_pool_of_distractions.clear()
	if _distractions_per_level.size() > 0:
		_current_pool_of_distractions.append_array(_distractions_per_level[0])
	
	print_debug("Pool of distractions at level %d : %s" % [_current_level , _current_pool_of_distractions])
	
	_level_timer.start()
	
	_new_distraction_trigger_timer.wait_time = rand_range(_min_distraction_wait_time, _max_distraction_wait_time)
	_new_distraction_trigger_timer.start()
	
	# DEBUG
#	for distraction in _current_pool_of_distractions:
#		distraction = distraction as Distraction
#		distraction.start_panic()

### DISTRACTION MANAGEMENT
func _process(delta):
	for distraction in _distractions_in_panic:
		_sleep_health -= delta # TODO ?? Add a power variable to each distraction
		_sleep_feedbacks.sleep_health = _sleep_health
	
	if _sleep_health <= 0:
		_lose_game()

func _on_NewDistractionTriggerTimer_timeout():
	_trigger_new_distraction()
	
	_new_distraction_trigger_timer.wait_time = rand_range(_min_distraction_wait_time, _max_distraction_wait_time)
	_new_distraction_trigger_timer.start()


func _trigger_new_distraction():
	if (_distractions_in_panic.size() == _current_pool_of_distractions.size()):
		return # Cannot add more distractions if they are already all in panic mode !
	
	var rand_index = rand_range(0,_current_pool_of_distractions.size())
	var distraction = _current_pool_of_distractions[rand_index] as Distraction
	
	while _distractions_in_panic.has(distraction):
		rand_index = rand_range(0,_current_pool_of_distractions.size())
		distraction = _current_pool_of_distractions[rand_index] as Distraction
	
	distraction.start_panic()
	_distractions_in_panic.append(distraction)
	
	print_debug("Start panic on %s" % distraction.name)


func _on_distraction_panic_ended(distraction):
	_distractions_in_panic.erase(distraction)
	
	print_debug("Distraction %s ended" % distraction.name)
	

### LEVEL MANAGEMENT

func _on_LevelTimer_timeout():
	if _current_level >= _highest_level:
		_win_game()
	else:
		_start_next_level()

func _start_next_level():
	_current_level += 1
	_current_pool_of_distractions.append_array(_distractions_per_level[0])
	
	print_debug("Start next level : %d" % _current_level)
	print_debug("Pool of distractions at level %d : %s" % [_current_level , _current_pool_of_distractions])


func _win_game():
	_scene_transition.transition_to(_win_scene_path)

func _lose_game():
	_scene_transition.transition_to(_lose_scene_path)



# Helpers

func _find_highest_distraction_level(distractions : Array):
	var highest_level := -1
	
	for distraction in distractions:
		distraction = distraction as Distraction
		if distraction.level > highest_level:
			highest_level = distraction.level
	
	return highest_level
