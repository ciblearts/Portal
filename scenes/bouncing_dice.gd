extends RigidBody2D


# Declare member variables here. Examples:
var first_touch
var release
onready var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("dice_roll"):
		first_touch = get_global_mouse_position()
	if Input.is_action_just_released("dice_roll"):
		release = get_global_mouse_position()
		var dir = -(release - first_touch).normalized()
		linear_velocity = dir * delta * 90000
