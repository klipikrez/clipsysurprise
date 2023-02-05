extends Panel

var dx: int = 1
var dy: int = 1

var timer = 8.0

func _process(delta):
	rect_position.x += dx*delta*200
	rect_position.y += dy*delta*200
	if rect_position.x < 0: dx = 1
	elif rect_position.x > get_viewport().size.x-rect_size.x: dx = -1
	if rect_position.y < 0: dy = 1
	elif rect_position.y > get_viewport().size.y-rect_size.y: dy = -1
	timer -= delta
	if timer <= 0: queue_free()
	
