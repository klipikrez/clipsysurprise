extends Control


var word = "nesto"
var typed = ""
const lines_string = """exploit
rootkit
crypto
firewall
inject
cyber
backdoor
malware
spyware
hijack
botnet
worm
virus
miner"""

func _ready():
	var lines: Array
	lines = lines_string.split("\n",false)
	word = lines[randi()%lines.size()]
	update()
	
func _draw():
	var string_size = get_theme_default_font().get_string_size(word)
	draw_string(get_theme_default_font(),-string_size/2.0,word,Color("#737373"))
	draw_string(get_theme_default_font(),-string_size/2.0,typed,Color.green)
	
func _input(event):
	if event is InputEventKey:
		if not event.pressed: return
		var letter = OS.get_scancode_string(event.scancode).to_lower()
		if not letter in "abcdefghijklmnopqrstuvwxyz0123456789": return
		if word[typed.length()] == letter:
			typed += letter
		if typed == word: get_parent().queue_free()
		update()
