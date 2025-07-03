extends Area2D

const SPEED := 300.0
@onready var collision_shape := $CollisionShape2D

func _ready():
	#Obtenemos las medidas de la collision shape del puddle 
	var screen_width = get_viewport().get_visible_rect().size.x
	global_position.x = screen_width / 2
	

func _process(delta):
	#if Input.is_action_pressed("move_left"):
	#	global_position.x -= SPEED * delta
	#if Input.is_action_pressed("move_right"):
	#	global_position.x += SPEED * delta
		
	var movement: float = Input.get_axis("move_left","move_right")
	global_position.x += SPEED * delta * movement
	var screen_width = get_viewport().get_visible_rect().size.x
	var half_width = collision_shape.shape.extents.x

	global_position.x = clampf(
		global_position.x, 
		half_width, 
		screen_width - half_width
		)


func _on_area_entered(area: Area2D) -> void:
	print("collision", area, "TEST ALE")
