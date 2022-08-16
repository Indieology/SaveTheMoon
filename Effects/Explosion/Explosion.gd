extends Node2D

var rng = RandomNumberGenerator.new()

onready var sound = $Sound

func _ready():
	rng.randomize()
	
	$AnimatedSprite.play("default")
	
	var random_number = rng.randi_range(1,3)
	match random_number:
		1:
			sound.stream = load("res://Sounds/Explosion/S_Fire_Throwing_Hit_1.wav")
		2:
			sound.stream = load("res://Sounds/Explosion/S_Fire_Throwing_Hit_2.wav")
		3:
			sound.stream = load("res://Sounds/Explosion/S_Fire_Throwing_Hit_3.wav")
	sound.play()
	
func _process(delta):
	if $AnimatedSprite.playing == false:
		queue_free()

func set_start_position(position):
	global_position = position
