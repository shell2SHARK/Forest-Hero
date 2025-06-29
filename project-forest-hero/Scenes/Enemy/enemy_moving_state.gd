extends State
class_name EnemyMovement

@onready var enemy : CharacterBody2D = get_parent().owner
var speedPatrol : float = 1.0
var direction : int = 1
var waitToCheck : bool = false

func enter():
	speedPatrol = enemy.enemyResource.speedPatrol

func update(delta: float):
	move(delta)
	
	# Usa essa bool para dar tempo do inimigo voltar e o raycast detectar o chao novamente
	if(!waitToCheck):
		check_to_flip()
	
func move(delta):
	enemy.gravity(delta)
	enemy.enemySpriteSheet.play("Walk")
	enemy.velocity.x = speedPatrol * direction
	enemy.move_and_slide()

func check_to_flip():
	# Se nao estiver mais tocando no chao, inverte o valor de direction para ir em outra direcao
	if(!enemy.raycastFloor.get_collider() is StaticBody2D):
		direction *= -1
		enemy.enemySpriteSheet.flip_h = direction < 0
		waitToCheck = true
		await get_tree().create_timer(0.25).timeout
		waitToCheck = false
