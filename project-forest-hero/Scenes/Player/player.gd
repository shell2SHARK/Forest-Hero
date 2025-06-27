extends CharacterBody2D

@export var playerResource : PlayerStats # Resource do jogador contendo sua data 
@onready var playerSpriteSheet := %AnimatedSprite2D # Coleta a folha de animacoes do player
var speed := 300.0
var jumpVelocity := -400.0

func _ready() -> void:
	# Aplica os valores da resource ao objeto jogador
	speed = playerResource.speed
	jumpVelocity = -playerResource.jumpForce

func _physics_process(delta: float) -> void:
	move_player(delta)

func move_player(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		playerSpriteSheet.animation = "Moving"
		playerSpriteSheet.flip_h = direction < 0 # Usa direction pra controlar a boleana
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		playerSpriteSheet.animation = "Idle"

	move_and_slide()
