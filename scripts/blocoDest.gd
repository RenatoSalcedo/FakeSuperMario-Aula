extends StaticBody2D
	
onready var particles = get_node("Particles2D")
onready var imagem = get_node("Sprite")
onready var shape = get_node("CollisionShape2D")

func destruir():
	imagem.queue_free()
	shape.queue_free()
	particles.set_emitting(true) 
