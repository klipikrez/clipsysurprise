extends Panel



func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.start(5.6)
	timer.connect("timeout",self,"queue_free")

