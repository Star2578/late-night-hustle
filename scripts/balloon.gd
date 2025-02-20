extends TextureRect

@export var sprites: Array[Texture2D]
var fall_speed: float = 3000
var fall_tick: float = 1.0
var counter: float = 0
var can_drop: bool = false

func _ready():
	texture = sprites[randi_range(0, sprites.size() - 1)]

func _physics_process(delta):
	if can_drop:
		counter += delta
		
		if counter >= fall_tick:
			position.y += fall_speed * delta
			counter = 0
			if position.y > 300:
				queue_free()

func _on_hit():
	pass
