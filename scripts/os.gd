extends MeshInstance3D

@export var decrease_every: float = 5.0

@onready var click_sound = $ClickSound

var battery: int = 100
var time_counter: float = 0.0

func _ready():
	print("OS ready")

func _physics_process(delta):
	if $"../../..".is_open:
		_decrease_battery(delta)
	else:
		time_counter = 0

func _decrease_battery(delta):
	time_counter += delta
	
	if time_counter >= decrease_every:
		battery -= 1
		time_counter = 0
		$OS/SubViewport/Battery/Label.text = str(battery) + "%"

func _open_mail():
	click_sound.play()
	print("Open Mail")
	$OS/SubViewport/Mail.visible = true
	$OS/SubViewport/Task.visible = false
	$OS/SubViewport/Game.visible = false

func _close_mail():
	click_sound.play()
	$OS/SubViewport/Mail.visible = false

func _open_task():
	click_sound.play()
	print("Open Task")
	$OS/SubViewport/Task.visible = true
	$OS/SubViewport/Mail.visible = false
	$OS/SubViewport/Game.visible = false

func _close_task():
	click_sound.play()
	$OS/SubViewport/Task.visible = false

func _open_game():
	click_sound.play()
	print("Open Game")
	$OS/SubViewport/Game.visible = true
	$OS/SubViewport/Mail.visible = false
	$OS/SubViewport/Task.visible = false

func _close_game():
	click_sound.play()
	$OS/SubViewport/Game.visible = false
