extends Area2D

export var health: int = 2

func _ready():
	pass # Replace with function body.



func _on_Blue_Enemy_area_entered(area):
	health -= 1
	if health <= 0:
		queue_free()
	
	area.get_parent().queue_free()
