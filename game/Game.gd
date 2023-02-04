extends Control

var line_number: int = 1
var required_text: String = "rootGetAccess -> true"

export(String,MULTILINE) var lines_string
var lines

const keyboard = [
	preload("res://sfx/keyboard/keyboard1.ogg"),
	preload("res://sfx/keyboard/keyboard2.ogg"),
	preload("res://sfx/keyboard/keyboard3.ogg"),
	preload("res://sfx/keyboard/keyboard4.ogg"),
	preload("res://sfx/keyboard/keyboard5.ogg")
]

func _on_LineEdit_text_entered(new_text):
	if new_text != required_text: return
	line_number += 1
	var label = Label.new()
	label.align = Label.ALIGN_RIGHT
	label.text = str(line_number)
	label.name = str(line_number)
	$HBoxContainer/LineNumbers.add_child(label)
	label = Label.new()
	label.text = $"%Input".text
	$"%Input".text = ""
	$HBoxContainer/Code.add_child(label)
	$"%Code".move_child($"%Input",$"%Code".get_child_count())
	old_text = ""
	required_text = lines[randi()%lines.size()]
	$HBoxContainer/Code/Input/Label.text = required_text
	
func scramble():
	var font = $"%Code".theme.default_font as DynamicFont
	font.font_data = preload("res://ui/font2.ttf")
	font.size = 29
	yield(get_tree().create_timer(2.0),"timeout")
	unscramble()
	
func unscramble():
	var font = $"%Code".theme.default_font as DynamicFont
	font.font_data = preload("res://ui/Consolas.ttf")
	font.size = 24
	
var popup_timer: Timer = Timer.new()
var popup2_timer: Timer = Timer.new()
var scramble_timer: Timer = Timer.new()

func _ready():
	randomize()
	$HBoxContainer/Code/Input.grab_focus()
	lines = lines_string.split("\n",false)
	
	scramble_timer.connect("timeout",self,"scramble")
	add_child(scramble_timer)
	scramble_timer.start(2.0)
	
	popup_timer.connect("timeout",self,"popup")
	add_child(popup_timer)
	popup_timer.start(10)
	
	popup2_timer.connect("timeout",self,"popup2")
	add_child(popup2_timer)
	popup2_timer.start(10)

var popups: float = 2.0
var popups2: float = 0.0

var done = false

func popup():
	popups += 1.0
	var t = 10*pow(0.85,popups)
	if t < 0.01 and not done:
		Global.animplayer.play("New Anim2")
		done = true
	popup_timer.wait_time = max(t,0.01)
	print(popup_timer.wait_time)
	var popup = preload("res://game/popup.tscn").instance()
	add_child(popup)
	var x = randf()*(get_viewport().get_size().x-popup.rect_size.x)
	var y = randf()*(get_viewport().get_size().y-popup.rect_size.y)
	popup.rect_position = Vector2(x,y)
	
func popup2():
	popups2 += 0.5
	popup2_timer.wait_time = 10*pow(0.9,popups)
	print(popup2_timer.wait_time)
	var popup = preload("res://game/kostur1.tscn").instance()
	add_child(popup)
	var x = randf()*(get_viewport().get_size().x-popup.rect_size.x)
	var y = randf()*(get_viewport().get_size().y-popup.rect_size.y)
	popup.rect_position = Vector2(x,y)

var old_text = ""

func _on_Input_text_changed(new_text):
	if not required_text.begins_with(new_text):
		print("ne")
		$"%Input".text = old_text
		$"%Input".caret_position = $"%Input".text.length()
	else:
		Global.play_sound(keyboard[randi()%5],-24)
		print("da")
		old_text = new_text
		
