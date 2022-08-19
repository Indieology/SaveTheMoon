extends StaticBody2D

export var max_health = 100
export var health = 100

onready var moon_health = get_parent().get_node("UI/MoonHealth")

func _ready():
	add_to_group("moon")


func _on_BulletDetector_area_entered(area):
	if area.get_parent().is_in_group("bullet"):
		health -= 5
		moon_health.value = health

func increase_max_health(added_health):
	max_health += added_health
	health += added_health * 2
	print(health)
	moon_health.max_value = max_health
	moon_health.value = health
	print("max health increased")

func damage(amount):
	health -= amount
	print(health)
