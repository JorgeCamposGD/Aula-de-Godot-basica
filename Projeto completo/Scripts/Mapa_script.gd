extends Node2D

var asteroid=preload("res://Cenas/Asteroid.tscn")
var ufo=preload("res://Cenas/UFO.tscn")
var nave_inimiga=preload("res://Cenas/Enemy.tscn")
onready var timer=get_node("Timer")



func _on_AsteroidTime_timeout():
	randomize()
	var chance=randi()%10
	var ast
	match chance:
		0,1,2,3:
			#ast=asteroid.instance()
			ast=asteroid.instance()
		4,5,6,7:
			ast=ufo.instance()
		8,9,10:
			ast=nave_inimiga.instance()
			ast.set_node_targuet(get_node("Nave"))
	get_parent().add_child(ast)
	ast.set_global_position(Vector2(rand_range(50,980), -200  ))

func end():
	timer.set_one_shot(true)
