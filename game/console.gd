extends Control

onready var vbox = $ScrollContainer/VBoxContainer
onready var input_line = $ScrollContainer/VBoxContainer/HBoxContainer
onready var input = $ScrollContainer/VBoxContainer/HBoxContainer/Input
onready var requirement = $ScrollContainer/VBoxContainer/HBoxContainer/Input/Label
onready var user = $ScrollContainer/VBoxContainer/HBoxContainer/Label

var required_input: String = ""
var current_input: String = ""

var line: int = 0
var busy: bool = false

func _ready():
	set_required_input("./floppy/free-game")
	input.grab_focus()

func set_required_input(text):
	required_input = text
	current_input = ""
	requirement.text = required_input

func add_line(text):
	var hbox = HBoxContainer.new()
	hbox.size_flags_horizontal = SIZE_EXPAND | SIZE_FILL
	var label = Label.new()
	label.set("custom_fonts/font",input.get("custom_fonts/font"))
	label.set("custom_colors/font_color",Color.green)
	label.text = text
	vbox.add_child(hbox)
	hbox.add_child(label)
	vbox.move_child(input_line,vbox.get_child_count())


func _on_Input_text_entered(new_text):
	if busy: return
	if new_text == required_input:
		add_line(user.text + new_text)
		input.text = ""
		line += 1
		match line:
			1:
				add_line("Starting free game...")
				input_line.visible = false
				busy = true
				yield(get_tree().create_timer(2.5),"timeout")
				Global.start_pong()

var old_text: String = ""

func _on_Input_text_changed(new_text):
	if busy:
		input.text = old_text
		return
	if required_input.begins_with(new_text):
		old_text = new_text
		input.caret_position = input.text.length()
	else:
		input.text = old_text
		input.caret_position = input.text.length()
