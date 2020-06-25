extends KinematicBody2D

const DANO_BASE=10
const COOLDOWN_BASE=0.5

onready var timer=get_node("Timer")
onready var sprite_da_nave=get_node("Sprite_da_nave")
onready var bl_pos=get_node("Bullet_pos")
onready var contador=get_node("Canvas/Contador_de_vidas")
onready var sprite_dano=get_node("Dano da Nave")
onready var dano_anim=get_node("Dano")

var bullet=preload("res://Cenas/Bullet.tscn")
var speed=500
var tipo_de_nave=1
var cor_da_nave="red"
var vetor_de_movimento=Vector2()
var movimento=Vector2()
var cooldown=0.5
var modificador=0
var cooldown_mod=0
var modificador_limite=3
var dano_recebido=0
var vidas=5
var dano
var escudo=false
var invensivel=false
func _ready():

	cooldown=COOLDOWN_BASE
	var imagem_para_nave=load("res://Naves aliadas/playerShip"+str(tipo_de_nave)+"_"+cor_da_nave+".png")
	sprite_da_nave.set_texture(imagem_para_nave)

func set_nave_e_cor(tipo,cor):
	cor_da_nave=cor
	tipo_de_nave=tipo

func _physics_process(delta):

	if Input.is_action_pressed("esquerda"):
		vetor_de_movimento.x=-1
	elif Input.is_action_pressed("direita"):
		vetor_de_movimento.x=1
	else:
		vetor_de_movimento.x=0
	
	if Input.is_action_pressed("cima"):
		vetor_de_movimento.y=-1
	elif Input.is_action_pressed("baixo"):
		vetor_de_movimento.y=1
	else:
		vetor_de_movimento.y=0
	
	if cooldown>0:
		cooldown-=delta

	if Input.is_action_just_released("Tiro") and cooldown<=0:
		var bl=bullet.instance()
		get_parent().add_child(bl)
		bl.set_global_position(bl_pos.get_global_position())
		bl.set_dano(DANO_BASE,modificador)
		cooldown=COOLDOWN_BASE-cooldown_mod
		modificador=0
	if Input.is_action_pressed("Tiro") and cooldown<=0:
		if modificador<modificador_limite:
			modificador+=delta

	movimento=(vetor_de_movimento*speed)
	movimento=move_and_slide(movimento)
	
func damage():

	if escudo or invensivel:
		return
	elif dano_recebido>-3:
		dano_recebido-=1
		sprite_dano.set_texture(load("res://Dano/playerShip"+str(tipo_de_nave)+"_damage"+str(abs(dano_recebido))+".png") )
		invensivel=true
		dano_anim.play("Dano")
		timer.start()
	
	elif dano_recebido>=-4:
		die()

func die():
	if vidas>-1:
		vidas-=1
		
	elif vidas<0:
		game_over()
func game_over():
	pass


func _on_Timer_timeout():
	invensivel=false
