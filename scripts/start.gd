extends Node


func _on_btnStart_pressed():
	get_node("Control/btnStart").modulate = Color(1, 1, 1, 0)
	transition.fade_to("res://scenes/main.tscn")
