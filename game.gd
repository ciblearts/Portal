extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var positions = $Positions
var pos1 = 1
var pos2 = 1
var dice

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move_player_one():
	if pos1 != 1 or dice ==1:
		for i in range (pos1, pos1 + dice):
			$YSort/Player1.transform = positions.get_node(str(i)).transform
			yield(get_tree().create_timer(0.5), "timeout")
		pos1 = pos1 + dice
	
func move_player_two():
	if pos2 != 1 or dice ==1:
		for i in range (pos2, pos2 + dice):
			$YSort/Player2.transform = positions.get_node(str(i)).transform
			yield(get_tree().create_timer(0.5), "timeout")
		pos2 = pos2 + dice
