extends CharacterBody2D

# Variaveis e nodes compartilhados
@onready var playerSpriteSheet := %AnimatedSprite2D # Coleta a folha de animacoes do player
@onready var attack_area := %Attack_Area
@onready var collisionBox : CollisionShape2D = %CollisionShape2D
@onready var life : float = playerResource.life
@export var playerResource : PlayerData # Resource do jogador contendo sua data 
var actualEnemy : CharacterBody2D

# Funcoes globais
func gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func set_damage(value: float):
	life -= value
	#print("perde vida " , life)
	
	if(life <= 0):
		# Chama o estado de dead imediatamente
		$State_Machine.set_new_state($State_Machine.actualState, "Dead")
	else:
		# Chama o estado de knockback imediatamente
		$State_Machine.set_new_state($State_Machine.actualState, "Knockback")

func _on_get_area_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Heal")):
		life += 1
		print(life)
		area.queue_free()
