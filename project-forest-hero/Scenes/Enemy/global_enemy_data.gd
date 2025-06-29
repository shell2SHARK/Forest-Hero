extends CharacterBody2D

@onready var enemySpriteSheet : AnimatedSprite2D = %AnimatedSprite2D
@onready var raycastFloor : RayCast2D = %RayCast2D
@export var enemyResource : EnemyStats
var life : float = 2

# Funcoes globais
func gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func set_damage(value: float):
	life -= value
	print("perde vida " , life)
	
	if(life <= 0):
		queue_free()
