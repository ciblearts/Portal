extends AnimatedSprite


signal clicked

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("left_click"):
		if getCurrentFrameRect().has_point(to_local(event.global_position)):
			print('clicked')
			emit_signal("clicked")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
