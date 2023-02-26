extends Distraction

onready var window: Node2D = $WindowDragable/Window
onready var bottle: Dragable = $"%Bottle"
onready var animated_sprite: AnimatedSprite = $AnimatedSprite

# Assume the window is position closed by default
func _ready():
	animated_sprite.frame = 0

func start_panic():
	.start_panic()
	animated_sprite.play()
	print("PLANNNNNNNNT start_panic")
	bottle.draggable = true

func _end_panic():
	._end_panic()
	animated_sprite.frame = 0
	animated_sprite
	bottle.draggable = false
	
func _on_Bottle_target_reached():
	_end_panic()

func _on_AnimatedSprite_animation_finished():
	animated_sprite.stop()
