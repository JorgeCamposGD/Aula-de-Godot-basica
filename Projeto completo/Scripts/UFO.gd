extends Area2D


const SPEED=50

onready var anim=get_node("Animated")


var vetor_de_movimento=Vector2(0,1)

func _physics_process(delta):
	global_position+=(vetor_de_movimento*SPEED)*delta



func _on_Asteroid_body_entered(body):
	if body.has_method("dano"):
		body.dano(1)

func dano(valor):
	anim.get_frame()
	queue_free()
