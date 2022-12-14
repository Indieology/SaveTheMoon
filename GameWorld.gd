extends Node2D

export var current_wave = 1
export var enemies_left_in_wave: int = 10
export var wave_increment_amount: int = 5

onready var spawn_points = $SpawnPoints
onready var spawn_timer = $EnemySpawnTimer
onready var rest_label = $UI/Rest
onready var moon = $Moon
onready var current_energy = $UI/CurrentEnergy
onready var player = $Pivot/Player

onready var upgrade_screen = get_node("UI/Upgrade Screen")
onready var health_upgrade_cost = upgrade_screen.get_node("HBoxContainer/IncreaseHealth/HBoxContainer/Amount")
onready var boot_upgrade_cost = upgrade_screen.get_node("HBoxContainer/BootUpgrade/HBoxContainer/Amount")
onready var damage_upgrade_cost = upgrade_screen.get_node("HBoxContainer/DamageUpgrade/HBoxContainer/Amount")

onready var enemy1 = preload("res://Enemies/Blue Enemy.tscn")

var enemies_in_last_wave: int
var player_near_ship = true
var wave_ended = false
var is_currently_upgrading = false
var current_day = 1

func _ready():
	enemies_in_last_wave = enemies_left_in_wave

#-270 -160

func _physics_process(delta):
	if get_node("Enemies").get_child_count() <= 0 and enemies_left_in_wave <= 0:
		wave_ended = true
		rest_label.show()
		if player_near_ship and Input.is_action_pressed("shoot"):
			$UI/AnimationPlayer.play("FadeToBlack")
			current_day += 1
			$UI/CurrentDayNumber.text = str(current_day)
			rest_label.hide()
			is_currently_upgrading = true
			
			enemies_left_in_wave = enemies_in_last_wave + wave_increment_amount
			if spawn_timer.wait_time >= 1:
				spawn_timer.wait_time -= .5
			
			
			if is_currently_upgrading == false:
				spawn_timer.start()

func _on_EnemySpawnTimer_timeout():
	#select random spawn point
	var last_enemy_spawn_location = 1
	if enemies_left_in_wave > 0:
		randomize()
		var random_point = rand_range(1, spawn_points.get_child_count())
		if random_point == last_enemy_spawn_location:
			_on_EnemySpawnTimer_timeout()
		else:
			last_enemy_spawn_location = random_point
			var this_random_point = spawn_points.get_child(random_point)
		
			var this_enemy = enemy1.instance()
			get_node("Enemies").add_child(this_enemy)
			this_enemy.global_position = this_random_point.global_position
		
			spawn_timer.start()
			enemies_left_in_wave -= 1

func _on_PlayerDetector_area_entered(area):
	if area.get_parent().name == "Player":
		player_near_ship = true


func _on_PlayerDetector_area_exited(area):
	if area.get_parent().name == "Player":
		player_near_ship = false


func _on_AnimationPlayer_animation_finished(anim_name):
	upgrade_screen.show()

#upgrade screen "close" button
func _on_Button_pressed():
	upgrade_screen.hide()
	wave_ended = false
	is_currently_upgrading = false
	_on_EnemySpawnTimer_timeout()


func _on_IncreaseHealth_pressed():
	if current_energy.text.to_int() >= health_upgrade_cost.text.to_int():
		moon.increase_max_health(10)
		current_energy.text = str(current_energy.text.to_int() - health_upgrade_cost.text.to_int())
		var update_cost = health_upgrade_cost.text.to_int() + 5
		health_upgrade_cost.text = str(update_cost)


func _on_BootUpgrade_pressed():
	if current_energy.text.to_int() >= boot_upgrade_cost.text.to_int():
		player.player_speed += 5
		current_energy.text = str(current_energy.text.to_int() - boot_upgrade_cost.text.to_int())
		var update_cost = boot_upgrade_cost.text.to_int() + 5
		boot_upgrade_cost.text = str(update_cost)


func _on_DamageUpgrade_pressed():
	if current_energy.text.to_int() >= damage_upgrade_cost.text.to_int():
		player.player_damage += 1
		current_energy.text = str(current_energy.text.to_int() - damage_upgrade_cost.text.to_int())
		var update_cost = damage_upgrade_cost.text.to_int() + 10
		damage_upgrade_cost.text = str(update_cost)
