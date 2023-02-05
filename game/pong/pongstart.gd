extends Control


func _ready():
	yield(get_tree().create_timer(2.0),"timeout")
	$TextureRect.queue_free()
	add_child(preload("res://game/pong/pong.tscn").instance())
