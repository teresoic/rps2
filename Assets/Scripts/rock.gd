extends CharacterBody2D

# Variables for movement speed and direction
@export var speed: float = 2000.0
var direction: Vector2

# Screen boundaries
var screen_size: Vector2

func _ready() -> void:
	# Get the screen size from the viewport
	screen_size = get_viewport().get_visible_rect().size

	# Set a random initial direction
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _physics_process(delta: float) -> void:
	# Move the sprite
	var velocity = direction * speed * delta
	

	# Check for collisions with screen edges and reverse direction if needed
	if position.x <= 0 or position.x >= screen_size.x:
		direction.x = -direction.x
		randomize_direction()
	if position.y <= 0 or position.y >= screen_size.y:
		direction.y = -direction.y
		randomize_direction()

	# Keep the position within screen bounds
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	move_and_slide()
	
func randomize_direction() -> void:
	# Slightly randomize direction to make it less predictable
	direction += Vector2(randf_range(-0.5, 0.5), randf_range(-0.5, 0.5)).normalized()
	direction = direction.normalized()

func randf_range(min_val: float, max_val: float) -> float:
	# Generate a random float within the range
	return randf() * (max_val - min_val) + min_val
