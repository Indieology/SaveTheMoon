extends KinematicBody2D

export var movement_speed: int = 100

onready var moon_center: = get_parent().get_parent().get_node("Pivot")

var velocity = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	look_at(moon_center.global_position)
	
	velocity = global_position.direction_to(moon_center.global_position) * movement_speed
	
	move_and_slide(velocity)

func set_start_position(position):
	global_position = position


func _on_PlayerDetector_area_entered(area):
	if area.name == "PowerUpDetector":
		area.get_parent().increase_power()
		queue_free()
