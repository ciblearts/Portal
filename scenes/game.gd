extends Node2D

onready var positions = $Positions
var turn = 1
var pos1 = 0
var pos2 = 0
var portals = []

var rng = RandomNumberGenerator.new()
var blue = preload("res://scenes/blue.tscn")
var yellow = preload("res://scenes/yellow.tscn")
var text = preload("res://scenes/text.tscn")
var confetti = preload("res://scenes/confetti.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	portals = generate_portals()
	place_portals(portals)
	place_numbers(portals)
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

func place_numbers(portals):
	for i in range(0, 100):
		var instance = text.instance()
		instance.rect_position = positions.get_node(str(i + 1)).global_position
		instance.text = str(i + 1)
		$Numbers.add_child(instance)

func move_player(flag, dice):
	$bouncing_dice.active = false
	var player = $YSort/Player1 if flag else $YSort/Player2
	var pos = pos1 if flag else pos2
#	var state = ps1_state if flag else ps2_state
#	if state:
	if pos + dice < 101:
		if  pos !=  0:
			for i in range (pos + 1, pos + dice + 1):
				player.transform = positions.get_node(str(i)).transform
				yield(get_tree().create_timer(0.5), "timeout")
				if i == 100:
					add_confetti()
					$Victory.play(String(flag))
					$Victory.show()
					dice = 2*pos - i - 2
					pos = i
			pos = pos + dice
			if portals.has(pos):
				player.material.set_shader_param("Strength", 10)
				var position = portals.find(pos)
				if position < 5:
					pos = portals[position + 5]
					player.transform = positions.get_node(str(pos)).transform
					yield(get_tree().create_timer(0.5), "timeout")
				player.material.set_shader_param("Strength", 1)
		elif dice == 1:
			pos = 1
			player.transform = positions.get_node(str(1)).transform
			yield(get_tree().create_timer(0.5), "timeout")
	update_pos(flag, pos, dice)

func update_pos(flag, pos, dice):
	if flag: 
		pos1 = pos
		if dice != 1:
			$YSort/Player2/Arrow.show()
			$YSort/Player1/Arrow.hide()
	else:
		pos2 = pos
		if dice != 1:
			$YSort/Player1/Arrow.show()
			$YSort/Player2/Arrow.hide()
	if pos == 100:
		print("victory")
		add_confetti()
		$Victory.play(String(flag))
		$Victory.show()

func add_confetti():
	var instance = confetti.instance()
	instance.position = $bouncing_dice.position
	add_child(instance)
