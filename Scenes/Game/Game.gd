extends Node2D

const EXPLODE = preload("res://assets/explode.wav")
const GEM = preload("res://Scenes/Gem/Gem.tscn")
const MARGIN: float = 70.0
@onready var spawn_timer: Timer = $SpawnTimer
@onready var paddle: Area2D = $Paddle
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var back_ground_sound: AudioStreamPlayer = $BackGroundSound

func _ready() -> void:
	spawn_gem()

func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	var x_pos: float = randf_range(
		get_viewport_rect().position.x +  MARGIN,
		get_viewport_rect().end.x - MARGIN
		
	)
	new_gem.position = Vector2(x_pos, - MARGIN)
	new_gem.gem_off_screen.connect(_on_gem_off_screen)
	add_child(new_gem)
	

func stop_all() -> void:
	back_ground_sound.stop()
	back_ground_sound.stream = EXPLODE
	back_ground_sound.play()
	spawn_timer.stop()
	paddle.set_process(false)
	for child in get_children():
		if child is Gem:
			child.set_process(false)

#	Calling the signals 
func _on_paddle_area_entered(area: Area2D) -> void:
	print("Game:: collision", area)
	if score_sound.playing == false:
		score_sound.position = area.position
		score_sound.play()

func _on_gem_off_screen() -> void:
	stop_all() # Replace with function body.

func _on_timer_timeout() -> void:
	spawn_gem() # Replace with function body.
