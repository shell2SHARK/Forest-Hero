extends CharacterBody2D

# Variaveis e nodes compartilhados
@onready var playerSpriteSheet := %AnimatedSprite2D # Coleta a folha de animacoes do player
@export var playerResource : PlayerStats # Resource do jogador contendo sua data 

func _physics_process(delta: float) -> void:
	gravity(delta)

# Funcoes globais
func gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		print("grav")
