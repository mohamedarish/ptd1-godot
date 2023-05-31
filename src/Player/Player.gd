extends CharacterBody2D

@export var SPEED = 50.0
@onready var character_sprite = $AnimatedSprite2D
@export var FRICTION = 50.0

func get_input() -> Vector2:
	if Input.is_action_pressed("ui_right"):
		return Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		return Vector2.LEFT
	elif Input.is_action_pressed("ui_up"):
		return Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		return Vector2.DOWN
	
	return Vector2.ZERO

func sprite_name_matcher(direction: Vector2):
	var sprite_name
	var sprite_direction = get_current_direction(direction)
	if velocity.x == 0 and velocity.y == 0:
		sprite_name = "Stil" + sprite_direction
	else:
		sprite_name = "Walk" + sprite_direction
	
	return sprite_name

func _physics_process(_delta: float) -> void:
	var direction = get_input()
	if direction != Vector2(0, 0):
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		velocity.y = move_toward(velocity.y, 0, FRICTION)
	
	character_sprite.play(sprite_name_matcher(direction))
	move_and_slide()

func get_current_direction(direction: Vector2):
	var sprite_direction
	match direction:
		Vector2.LEFT:
			sprite_direction = "Left"
		Vector2.RIGHT:
			sprite_direction = "Right"
		Vector2.UP:
			sprite_direction = "Up"
		Vector2.DOWN:
			sprite_direction = "Down"
		_:
			sprite_direction = character_sprite.animation.substr(4)
	
	return sprite_direction
	
