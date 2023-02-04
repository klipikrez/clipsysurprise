extends Sprite3D


func _ready():
	Global.animplayer = $"../AnimationPlayer"

func _process(delta):
	texture = $Viewport.get_texture()

func _input(event):
	$Viewport.input(event)

func set_process(a: bool):
	$Viewport.set_process(a)
	$Viewport/Game.set_process(a)
	.set_process(a)
