extends Sprite3D


func _ready():
	Global.animplayer = $"../AnimationPlayer"
	Global.connect("pong_done",self,"trigger_cutscene")

func _process(delta):
	texture = $Viewport.get_texture()

func _input(event):
	$Viewport.input(event)

func set_process(a: bool):
	$Viewport.set_process(a)
	$Viewport/Game.set_process(a)
	.set_process(a)

func start_pong():
	var vc = $Viewport/Control
	vc.remove_child(vc.get_child(0))
	var pong = preload("res://game/pong/pongstart.tscn").instance()
	vc.add_child(pong)

func start_console():
	var vc = $Viewport/Control
	vc.remove_child(vc.get_child(0))
	var console = preload("res://game/console.tscn").instance()
	vc.add_child(console)
	
func start_console2():
	var vc = $Viewport/Control
	vc.remove_child(vc.get_child(0))
	var console = preload("res://game/Game.tscn").instance()
	vc.add_child(console)

func trigger_cutscene():
	Global.animplayer.play("New Anim2")
