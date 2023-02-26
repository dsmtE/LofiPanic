extends Sprite

class_name Hint

export(int) var show_count = 2

var count: int = 0

func _ready():
	change_visibility(false)
	
func start_panic():
	print("hint panic")
	count+=1
	if(count <= show_count):
		change_visibility(true)
	
func end_panic():
	change_visibility(false)

func change_visibility(value: bool):
	visible = value
	
