extends AnimatableBody2D

@export var shake_duration: float = 1.0
@export var fall_speed: float = 500.0
@export var shake_magnitude: float = 5.0

@onready var sprite := $Sprite2D

var is_shaking := false
var shake_timer := 0.0
var original_sprite_position: Vector2
var fall_started := false

func _ready():
	original_sprite_position = sprite.position
	constant_linear_velocity = Vector2.ZERO

func _physics_process(delta):
	shake_and_fall(delta)

func start_shake():
	if not is_shaking and not fall_started:
		is_shaking = true
		shake_timer = shake_duration

func shake_and_fall(delta):
	if is_shaking:
		shake_timer -= delta

		# Apenas o sprite treme
		var offset = Vector2(
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0)
		) * shake_magnitude
		sprite.position = original_sprite_position + offset

		if shake_timer <= 0.0:
			is_shaking = false
			fall_started = true
			sprite.position = original_sprite_position  # reset visual antes da queda

	if fall_started:
		position.y += fall_speed * delta

func _on_area_detect_player_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		start_shake()
