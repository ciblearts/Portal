extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var positions = $Positions
var pos1 = 1
var pos2 = 1
var dice
var portals = []

var rng = RandomNumberGenerator.new()
var blue = preload("res://scenes/blue.tscn")
var yellow = preload("res://scenes/yellow.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	portals = generate_portals()
	place_portals(portals)
	print(portals)

func generate_portals():
	var numbers = []
	while numbers.size() < 10:
		rng.randomize()
		var r = rng.randi_range(11, 89)
		if !numbers.has(r):
			numbers.append(r)
	return numbers
	
func place_portals(portals):
	for i in range (0, len(portals)/2):
		var instance = blue.instance()
		instance.position = positions.get_node(str(portals[i])).global_position
		$Portals.add_child(instance)
	for i in range (len(portals)/2, len(portals)):
		var instance = yellow.instance()
		instance.position = positions.get_node(str(portals[i])).global_position
		$Portals.add_child(instance)

func move_player_one():
	if pos1 != 1 or dice ==1:
		for i in range (pos1, pos1 + dice):
			$YSort/Player1.transform = positions.get_node(str(i)).transform
			yield(get_tree().create_timer(0.5), "timeout")
		pos1 = pos1 + dice
		if portals.has(pos1):
			var pos = portals.find(pos1)
			if pos < 5:
				pos1 = portals[pos+5]
				$YSort/Player2.transform = positions.get_node(str(pos1)).transform
				yield(get_tree().create_timer(0.5), "timeout")
	
func move_player_two():
	if pos2 != 1 or dice ==1:
		for i in range (pos2, pos2 + dice):
			$YSort/Player2.transform = positions.get_node(str(i)).transform
			yield(get_tree().create_timer(0.5), "timeout")
		pos2 = pos2 + dice
		if portals.has(pos2):
			var pos = portals.find(pos2)
			if pos < 5:
				pos2 = portals[pos+5]
				$YSort/Player2.transform = positions.get_node(str(pos2)).transform
				yield(get_tree().create_timer(0.5), "timeout")
