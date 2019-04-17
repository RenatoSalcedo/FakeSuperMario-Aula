extends KinematicBody2D

var direcao = 1
onready var enemy = get_node("Sprite")
onready var animation = get_node("AnimationPlayer")

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var nOffset = get_parent().unit_offset + delta*direcao*0.5
	
	if direcao == 1 and nOffset >= 0.99999:
		direcao = -1
		get_parent().unit_offset = 0.99999
	elif direcao == -1 and nOffset <= 0:
		direcao = 1
		get_parent().unit_offset = 0
	else:
		get_parent().unit_offset = nOffset