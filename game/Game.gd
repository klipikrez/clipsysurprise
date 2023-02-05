extends Control

onready var vbox = $ScrollContainer/VBoxContainer
onready var input_line = $ScrollContainer/VBoxContainer/HBoxContainer
onready var input = $ScrollContainer/VBoxContainer/HBoxContainer/Input
onready var requirement = $ScrollContainer/VBoxContainer/HBoxContainer/Input/Label
onready var user = $ScrollContainer/VBoxContainer/HBoxContainer/Label

var line_number: int = 1
var required_input: String = ""

onready var code_font: DynamicFont = get_theme_default_font()

export(String,MULTILINE) var lines_string
var lines

const keyboard = [
	preload("res://sfx/keyboard/keyboard1.ogg"),
	preload("res://sfx/keyboard/keyboard2.ogg"),
	preload("res://sfx/keyboard/keyboard3.ogg"),
	preload("res://sfx/keyboard/keyboard4.ogg"),
	preload("res://sfx/keyboard/keyboard5.ogg")
]

func _ready():
	randomize()
	set_required_input("sudo rm -rf ./floppy/free-game")
	input.grab_focus()
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
	
func set_required_input(text):
	required_input = text
	requirement.text = required_input
	
var line: int = 0

func add_line(text):
	var label = Label.new()
	label.text = text
	input.text = ""
	vbox.add_child(label)
	vbox.move_child(input_line,vbox.get_child_count())

func _on_Input_text_entered(new_text):
	if new_text != required_input: return
	line_number += 1
	add_line(user.text + input.text)
	old_text = ""
	#required_input = lines[randi()%lines.size()]
	required_input = ""
	requirement.text = required_input
	line += 1
	add_line("You must have root privileges to do that!")
			
	
func scramble():
	code_font.font_data = preload("res://ui/font2.ttf")
	code_font.size = 29
	yield(get_tree().create_timer(2.0),"timeout")
	unscramble()
	
func unscramble():
	code_font.font_data = preload("res://ui/Consolas.ttf")
	code_font.size = 24
	
var popup_timer: Timer = Timer.new()
var popup2_timer: Timer = Timer.new()
var scramble_timer: Timer = Timer.new()



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
	if required_input != "" and required_input.begins_with(new_text):
		Global.play_sound(keyboard[randi()%5],-24)
		old_text = new_text
		input.caret_position = input.text.length()
	else:
		input.text = old_text
		input.caret_position = input.text.length()
		


