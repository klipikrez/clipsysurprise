extends Node


var score1 = 0
var score2 = 0

func _ready():
	update_score()


func ball_fall(body, player):
	var s = "score"+str(3-player)
	set(s,get(s)+1)
	update_score()
	Global.ball.position = Vector2(512,112)
	Global.ball._ready()
	Global.ball.gravity = Global.ball.default_gravity
	Global.ball.bounces = 0
	if score2 == 2:
		Global.emit_signal("pong_done")

func _process(delta):
	if Input.is_action_just_pressed("close"):
		Global.start_console2()

func update_score():
	$CanvasLayer/Score1.text = str(score1)
	$CanvasLayer/Score2.text = str(score2)
