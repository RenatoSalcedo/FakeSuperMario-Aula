extends Area2D

onready var anim = get_node("animation")
onready var shp = get_node("Shape")

func _ready():
	pass 


func _on_moeda_body_entered(body):
	body.moeda()
	anim.play("coleta")
	shp.queue_free()
	yield(anim, "animation_finished")
	queue_free()