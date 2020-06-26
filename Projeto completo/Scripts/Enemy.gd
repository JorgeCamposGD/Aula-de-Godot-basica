extends KinematicBody2D

onready var timer=get_node("Timer")
onready var posicao=get_node("PosicaoDaBala")
onready var sprite=get_node("Sprite")
var enemy_bl=preload("res://Cenas/Bullet_enemy.tscn")
var targuet
var mov=Vector2(1,0)
var speed=100
var node_targuet
var pode_atirar=false
var multiplicador
var hp=5

func _ready():
	randomize()
	var random

	random=randi()%4+1
	multiplicador=random
	hp=random
	sprite.set_texture(load("res://Naves Inimigas/enemyBlack"+str(random)+".png"))


func _physics_process(delta):
	mov=Vector2()
	if node_targuet!=null:
		if targuet==get_targuet_vec(node_targuet):
			mov=Vector2(0,1)*speed
		else:
			if (abs(global_position.x-node_targuet.get_global_position().x)>5) and global_position.y<node_targuet.get_global_position().y-100:
	
				mov=Vector2(targuet.x*multiplicador,1) *speed
				
			else:
				mov=Vector2(0,1)*speed
				if pode_atirar:
					atira()
	mov=move_and_slide(mov)

func get_targuet_vec(pos):
	var new_targuet=Vector2(0,1)
	new_targuet.x=sign(pos.get_global_position().x-global_position.x)
	new_targuet.y=1
	targuet=new_targuet

func set_node_targuet(node):
	node_targuet=node

func atira():
	pode_atirar=false
	var nova_bala=enemy_bl.instance()
	get_parent().add_child(nova_bala)
	nova_bala.set_global_position( posicao.get_global_position() )
	timer.start()

func dano(valor):

	hp-=1
	if hp<=0:
		die()

func die():
	queue_free()


func _on_Timer_timeout():
	pode_atirar=true


func _on_VisibilityNotifier2D_screen_entered():
	pode_atirar=true


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
