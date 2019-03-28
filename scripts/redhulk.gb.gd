extends KinematicBody2D

var direcao = 1
onready var redhulk = get_node("Sprite")

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var nOffset = get_parent().unit_offset + delta*direcao*0.4
	
	if direcao == 1 and nOffset >= 0.99999:
		direcao = -1
		get_parent().unit_offset = 0.99999
		redhulk.set_flip_h(true)
	elif direcao == -1 and nOffset <= 0:
		direcao = 1
		get_parent().unit_offset = 0
		redhulk.set_flip_h(false)
	else:
		get_parent().unit_offset = nOffset