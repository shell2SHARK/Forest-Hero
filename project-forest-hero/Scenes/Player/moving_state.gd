extends State
class_name PlayerMovement

@export var playerResource : PlayerStats # Resource do jogador contendo sua data 
@onready var playerSpriteSheet := %AnimatedSprite2D # Coleta a folha de animacoes do player
@onready var player : CharacterBody2D = get_parent().owner
var speed = 0
var jumpVelocity = 0

func enter():
	# Aplica os valores da resource ao objeto jogador
	speed = playerResource.speed
	jumpVelocity = -playerResource.jumpForce

func update(delta: float):
	move_player(delta)
	
	if(Input.is_action_just_pressed("attack_player") and player.is_on_floor()):
		changed_state.emit(self, "Attack")

func move_player(delta) -> void:
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * speed
		playerSpriteSheet.play("Moving")
		playerSpriteSheet.flip_h = direction < 0 # Usa direction pra controlar a boleana
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		playerSpriteSheet.play("Idle")

	player.move_and_slide()
