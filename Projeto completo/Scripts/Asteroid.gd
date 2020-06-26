extends Area2D


onready var colisores=[get_node("1"),get_node("2"),get_node("3"),get_node("4")]
const SPEED=50
var vetor_de_movimento=Vector2(0,1)
onready var sprite=get_node("sprite")

func _physics_process(delta):
	global_position+=(vetor_de_movimento*SPEED)*delta

func _ready():
	randomize()
	var tipo=randi()%3
	sprite.set_texture( load("res://Meteoros/meteorBrown_big"+str(tipo+1)+".png")  )
	colisores[tipo].set_disabled(false)



func _on_Asteroid_body_entered(body):
	if body.has_method("dano"):
		body.dano(1)

func dano(valor):
	queue_free()
