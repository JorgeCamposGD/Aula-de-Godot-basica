extends Area2D


export (int,"player","enemy") var player=false
export (int,100,1200) var speed=1200
var vetor_de_movimento=Vector2(0,-1)
var dano

func _ready():
	vetor_de_movimento=vetor_de_movimento.rotated(get_rotation())

func _physics_process(delta):
	global_position+=(vetor_de_movimento*speed)*delta



func _on_Area_body_entered(body):
	if body.has_method("dano"):
		body.dano(dano)
		queue_free()

func set_dano(valor,modificador):
	dano=valor
	if modificador!=null:
		dano*=modificador+1



func _on_Area_area_entered(area):
	if area.has_method("dano"):
		area.dano(dano)
		if player==0:
			get_parent().get_node("Nave").set_point(50)
		queue_free()
