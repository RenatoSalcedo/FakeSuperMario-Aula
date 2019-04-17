extends Node

onready var charc = get_node("char")
onready var spawnLocale = get_node("Spawn_Pos")
onready var spawnTime = get_node("Spawn_Timer")

onready var money = get_node("CanvasLayer/Panel/moedas")
onready var sz1 = get_node("CanvasLayer/Panel/Heart1")
onready var sz2 = get_node("CanvasLayer/Panel/Heart2")
onready var sz3 = get_node("CanvasLayer/Panel/Heart3")

onready var finalCam = get_node("final_camera")
onready var mainCam = get_node("char/camera")

var moedas = 0
var lifes = 3

func _ready():
	set_process(true)

func _process(delta):
	get_node("CanvasLayer/Panel/time").text = str(int(get_node("game_time").time_left))

func change_camera():
	finalCam.position = mainCam.get_camera_position()
	finalCam.make_current()

func _on_char_morreu():
	change_camera()
	spawnTime.set_wait_time(1.5)
	spawnTime.start()
	
	lifes -= 1
	if lifes == 2:
		sz1.texture = load("res://assets/hud_heartEmpty.png")
	elif lifes == 1:
		sz2.texture = load("res://assets/hud_heartEmpty.png")
	else:
		sz3.texture = load("res://assets/hud_heartEmpty.png")
		


func _on_Spawn_Timer_timeout():
	if lifes > 0:
		reborn()
	else:
		transition.fade_to("res://scenes/start.tscn")

func reborn():
	charc.position = spawnLocale.position
	charc.reborn()
	
	get_node("game_time").wait_time = 300
	get_node("game_time").start()
	
	mainCam.make_current()


func _on_char_finish():
	change_camera()
	
	spawnTime.set_wait_time(3)
	spawnTime.start()


func _on_char_moeda():
	moedas += 1
	money.text = str(moedas)
