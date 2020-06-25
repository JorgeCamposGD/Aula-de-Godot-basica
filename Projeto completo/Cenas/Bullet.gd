extends Area2D

const SPEED=1200
var vetor_de_movimento=Vector2(0,-1)
var dano


func _physics_process(delta):
	global_position+=(vetor_de_movimento*SPEED)*delta



func _on_Area_body_entered(body):
	if body.has_method("dano"):
		body.dano(dano)

func set_dano(valor,modificador):
	dano=valor
	if modificador!=null:
		dano*=modificador+1
