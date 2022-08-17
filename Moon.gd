extends StaticBody2D

export var health = 100

func _ready():
	add_to_group("moon")


func _on_BulletDetector_area_entered(area):
	if area.get_parent().is_in_group("bullet"):
		health -= 5
		get_parent().get_node("UI/MoonHealth").value = health
