extends Node

onready var charc = get_node("char")
onready var spawnLocale = get_node("Spawn_Pos")
onready var spawnTime = get_node("Spawn_Timer")

func _ready():
	pass 


func _on_char_morreu():
	spawnTime.set_wait_time(1.5)
	spawnTime.start()


func _on_Spawn_Timer_timeout():
	reborn()

func reborn():
	charc.position = spawnLocale.position
	charc.reborn()


func _on_char_finish():
	pass # Replace with function body.
