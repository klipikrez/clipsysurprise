extends Node

signal pong_done

var animplayer: AnimationPlayer
var ball: PongBall

func play_sound(sound: AudioStream, volume: float = 0.0):
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = sound
	player.volume_db = volume
	player.play()
	player.connect("finished",player,"queue_free")

func start_pong():
	get_tree().current_scene.get_node("svwe4/Screen").start_pong()

func start_console2():
	get_tree().current_scene.get_node("svwe4/Screen").start_console2()
