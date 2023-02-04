extends Node

var animplayer: AnimationPlayer

func play_sound(sound: AudioStream, volume: float = 0.0):
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = sound
	player.volume_db = volume
	player.play()
	player.connect("finished",player,"queue_free")
