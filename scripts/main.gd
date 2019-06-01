extends Node

onready var charac = get_node("char")
onready var spawnPos = get_node("Spawn_Pos")
onready var spawnTime = get_node("Spawn_Timer")

func _ready():
	pass 

func _on_char_morreu():
	spawnTime.set_wait_time(1.5)
	spawnTime.start()

func _on_Spawn_Timer_timeout():
	resurrect()

func resurrect():
	charac.position = spawnPos.position
	charac.reborn()