extends Node2D

var rng = RandomNumberGenerator.new()
var bale = preload("res://World/Objects/hayBales/Sideways_bale.tscn")
var plot = preload("res://World/Objects/cropPlots/cropPlot.tscn")
var enemy = preload("res://Enemies/Farmer1.tscn")

var numb_plots = PlayerStats.numb_plots
var numb_bales = PlayerStats.numb_bales
var numb_enemies =  PlayerStats.numb_enemies

func _ready():
	$YSort/cropplots/e.visible = PlayerStats.visible_e
	$YSort/cropplots/arrow.visible = PlayerStats.visible_arrow_e
	rng.randomize()
	add_objects()
	PlayerStats.visible_e = false
	PlayerStats.visible_arrow_e = false
	
func _process(delta):
	var _moveingGroup = get_tree().get_nodes_in_group("movingGroup")
	for _i in _moveingGroup:
		_i.position.x -= 4.9
	
func add_objects():
	add_bales()
	add_plots()
	add_enemies()
	
func add_bales():
	for i in range(numb_bales):
		var Bale = bale.instance()
		var rndX = rng.randi_range(1366, 2000)
		var rndY = rng.randi_range(194, 550)
		Bale.position = Vector2(rndX, rndY)
		get_node("YSort/HayBales").add_child(Bale)
	
func add_plots():
	for i in range(numb_plots):
		var Plot = plot.instance()
		var rndX = rng.randi_range(1366, 2000)
		var rndY = rng.randi_range(194, 550)
		Plot.position = Vector2(rndX, rndY)
		get_node("YSort/cropplots").add_child(Plot)
	
func add_enemies():
	for i in range(numb_enemies):
		var Enemy = enemy.instance()
		var rndX = rng.randi_range(1366, 1800)
		var rndY = rng.randi_range(194, 750)
		Enemy.position = Vector2(rndX, rndY)
		get_node("YSort/Enemies").add_child(Enemy)


func _on_Timer_timeout():
	add_objects()
