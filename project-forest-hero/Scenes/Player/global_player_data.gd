extends CharacterBody2D

# Variaveis e nodes compartilhados
@onready var playerSpriteSheet := %AnimatedSprite2D # Coleta a folha de animacoes do player
@onready var attack_area := %Attack_Area
@export var playerResource : PlayerData # Resource do jogador contendo sua data 
var life := 1

func _physics_process(delta: float) -> void:
	gravity(delta)

# Funcoes globais
func gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _on_get_area_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Heal")):
		life += 1
		print(life)
		area.queue_free()
