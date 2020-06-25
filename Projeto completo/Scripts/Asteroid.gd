extends Area2D


onready var colisores=[get_node("1"),get_node("2"),get_node("3"),get_node("4")]
const SPEED=50
var vetor_de_movimento=Vector2(0,1)


func _physics_process(delta):
	global_position+=(vetor_de_movimento*SPEED)*delta

func _ready():
	randomize()
	var tipo=randi()%3

	colisores[tipo].set_disabled(false)



func _on_Asteroid_body_entered(body):
	if body.has_method("damage"):
		body.damage()
