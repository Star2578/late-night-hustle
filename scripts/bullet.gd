extends TextureRect

var speed: float = 2000
var tick: float = 0.5
var counter: float = 0

func _physics_process(delta):
	counter += delta
	
	if counter >= tick:
		position.y -= speed * delta
		counter = 0
		if position.y < 0:
			queue_free()
