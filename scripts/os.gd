extends MeshInstance3D

@export var decrease_every: float = 5.0

@onready var click_sound = $ClickSound

var battery: int = 100
var time_counter: float = 0.0

func _input(event):
	if text_edit.has_focus():
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_TAB:
				get_viewport().set_input_as_handled()  # Ignore Tab input
				return  # Prevents tab switching

			elif event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
				_check_word()  # Treat Enter like Space
				get_viewport().set_input_as_handled()  # Prevent newline

			elif event.keycode == KEY_SPACE:
				_check_word()  # Normal space behavior


func _ready():
	print("OS ready")

func _physics_process(delta):
	if $"../../..".is_open:
		_decrease_battery(delta)
		if is_start:
			_doing_task(delta)
	else:
		time_counter = 0

func _decrease_battery(delta):
	time_counter += delta
	
	if time_counter >= decrease_every:
		battery -= 1
		time_counter = 0
		$OS/SubViewport/Battery/Label.text = str(battery) + "%"
	
	$OS/SubViewport/Battery/Value.scale.x = battery / 100


#################### Mail ####################

func _open_mail():
	click_sound.play()
	print("Open Mail")
	$OS/SubViewport/Mail.visible = true
	_close_task()
	$OS/SubViewport/Game.visible = false

func _close_mail():
	click_sound.play()
	$OS/SubViewport/Mail.visible = false

func _mail_one():
	click_sound.play()
	$"OS/SubViewport/Mail/MailBG/Content#1".visible = true
	$"OS/SubViewport/Mail/MailBG/Content#2".visible = false
	$"OS/SubViewport/Mail/MailBG/Content#3".visible = false

func _mail_two():
	click_sound.play()
	$"OS/SubViewport/Mail/MailBG/Content#1".visible = false
	$"OS/SubViewport/Mail/MailBG/Content#2".visible = true
	$"OS/SubViewport/Mail/MailBG/Content#3".visible = false

func _mail_three():
	click_sound.play()
	$"OS/SubViewport/Mail/MailBG/Content#1".visible = false
	$"OS/SubViewport/Mail/MailBG/Content#2".visible = false
	$"OS/SubViewport/Mail/MailBG/Content#3".visible = true


#################### Task ####################

@onready var progress_bar = $OS/SubViewport/Task/TaskBG/ProgressBar
@onready var task_bg = $OS/SubViewport/Task/TaskBG
@onready var word_label = $OS/SubViewport/Task/TaskBG/RichTextLabel
@onready var text_edit = $OS/SubViewport/Task/TaskBG/TextEdit
var tasks_progress = [0, 0, 0, 0, 0, 0]
var idx = -1 # not select any task
var tick = 1.0 # task increase tick rate
var is_start = false

var word_list = [
	"ghost", "water", "hello", "new", "death", "sleep", "work", "midnight", "hungry",
	"friends", "closet", "inside", "noise", "scare", "horror", "cold", "laptop", "bedroom",
	"alien", "wrong", "duck", "entangle", "haste", "xX_DarkL0rd_Xx", "peaceful", "imagination",
	"wind", "around", "corner", "lights", "battery", "clock", "mouse", "healthy", "gamer",
	"apologize", "cunning", "thoughts", "bucket", "moon", "haunting", "look", "awake", "chair",
	"close", "lookatyourleft", "something", "pearl", "funny", "yourname", "earth", "pluto", "lucky",
	"noice", "playing", "elephant", "birb", "howareyou", "emerge", "click", "correct", "colorful",
	"sparkly", "balloon", "popcorn", "marcus", "looking", "hiding", "peeking", "break", "anxiety",
	"sound", "pills", "drink", "trash", "godmode", "performance", "crawling", "hunting", "mewing",
]  
var current_words = []  # Words currently displayed
var current_index = 0  # Position in the list

func _open_task():
	click_sound.play()
	print("Open Task")
	$OS/SubViewport/Task.visible = true
	$OS/SubViewport/Mail.visible = false
	$OS/SubViewport/Game.visible = false
	$OS/SubViewport/Task/TaskBG/ProgressBar.visible = false
	$OS/SubViewport/Task/TaskBG/Start.visible = false
	text_edit.visible = false
	word_label.visible = false

func _close_task():
	click_sound.play()
	if idx != -1: tasks_progress[idx] = progress_bar.value
	$OS/SubViewport/Task.visible = false
	task_bg.visible = false
	is_start = false
	idx = -1

func _task_one():
	click_sound.play()
	if idx == 0: return
	
	is_start = false
	tasks_progress[idx] = progress_bar.value
	idx = 0
	progress_bar.value = tasks_progress[idx]
	task_bg.visible = true
	
	$OS/SubViewport/Task/TaskBG/ProgressBar.visible = true
	$OS/SubViewport/Task/TaskBG/Start.visible = progress_bar.value != 100
	text_edit.visible = false
	word_label.visible = false

func _task_two():
	click_sound.play()
	if idx == 1: return
	
	is_start = false
	tasks_progress[idx] = progress_bar.value
	idx = 1
	progress_bar.value = tasks_progress[idx]
	task_bg.visible = true
	
	$OS/SubViewport/Task/TaskBG/ProgressBar.visible = true
	$OS/SubViewport/Task/TaskBG/Start.visible = progress_bar.value != 100
	text_edit.visible = false
	word_label.visible = false

func _task_three():
	click_sound.play()
	if idx == 2: return
	
	is_start = false
	tasks_progress[idx] = progress_bar.value
	idx = 2
	progress_bar.value = tasks_progress[idx]
	task_bg.visible = true
	
	$OS/SubViewport/Task/TaskBG/ProgressBar.visible = true
	$OS/SubViewport/Task/TaskBG/Start.visible = progress_bar.value != 100
	text_edit.visible = false
	word_label.visible = false

func _task_four():
	click_sound.play()
	if idx == 3: return
	
	is_start = false
	tasks_progress[idx] = progress_bar.value
	idx = 3
	progress_bar.value = tasks_progress[idx]
	task_bg.visible = true
	
	$OS/SubViewport/Task/TaskBG/ProgressBar.visible = true
	$OS/SubViewport/Task/TaskBG/Start.visible = progress_bar.value != 100
	text_edit.visible = false
	word_label.visible = false

func _task_five():
	click_sound.play()
	if idx == 4: return
	
	is_start = false
	tasks_progress[idx] = progress_bar.value
	idx = 4
	progress_bar.value = tasks_progress[idx]
	task_bg.visible = true
	
	$OS/SubViewport/Task/TaskBG/ProgressBar.visible = true
	$OS/SubViewport/Task/TaskBG/Start.visible = progress_bar.value != 100
	text_edit.visible = false
	word_label.visible = false

func _task_six():
	click_sound.play()
	if idx == 5: return
	
	is_start = false
	tasks_progress[idx] = progress_bar.value
	idx = 5
	progress_bar.value = tasks_progress[idx]
	task_bg.visible = true
	
	$OS/SubViewport/Task/TaskBG/ProgressBar.visible = true
	$OS/SubViewport/Task/TaskBG/Start.visible = progress_bar.value != 100
	text_edit.visible = false
	word_label.visible = false

func _start_task():
	click_sound.play()
	is_start = true
	$OS/SubViewport/Task/TaskBG/Start.visible = false
	text_edit.visible = true
	word_label.visible = true
	
	text_edit.clear()
	_generate_words()

func _doing_task(delta):
	if progress_bar.value == 100:
		$TaskDoneSound.play()
		$OS/SubViewport/Task/TaskBG/Start.visible = false
		text_edit.visible = false
		word_label.visible = false
		is_start = false

	progress_bar.value += delta / tick

func _generate_words():
	current_words = []
	for i in range(5):  # Show 5 words at a time
		current_words.append(word_list[randi() % word_list.size()])
	word_label.text = " ".join(current_words)
	current_index = 0  # Reset word index
	_update_label()

func _update_label():
	var formatted_text = ""
	for i in range(current_words.size()):
		if i == current_index:
			formatted_text += "[b]" + current_words[i] + "[/b] "
		else:
			formatted_text += current_words[i] + " "
	
	formatted_text = "[center]" + formatted_text + "[/center]"
	
	word_label.text = formatted_text.strip_edges()  # Apply BBCode formatting
	word_label.queue_redraw()  # Ensure it's updated

func _check_word():
	var typed_word = text_edit.text.strip_edges()  # Remove spaces
	var correct_word = current_words[current_index]

	if typed_word == correct_word:
		# Correct: Move to next word, increase progress
		current_index += 1
		progress_bar.value += 2
		$CorrectSound.play()
		_update_label()  # Refresh highlighting
	else:
		# Incorrect: Show error effect
		text_edit.add_theme_color_override("font_color", Color(1, 0, 0))  # Red text
		$ErrorSound.play()
		await get_tree().create_timer(0.3).timeout
		text_edit.add_theme_color_override("font_color", Color(1, 1, 1))  # Reset color

	# Clear input field
	text_edit.text = ""

	# If all words are typed, generate new ones
	if current_index >= current_words.size():
		_generate_words()


#################### Game ####################

func _open_game():
	click_sound.play()
	print("Open Game")
	$OS/SubViewport/Game.visible = true
	$OS/SubViewport/Mail.visible = false
	_close_task()

func _close_game():
	click_sound.play()
	$OS/SubViewport/Game.visible = false
