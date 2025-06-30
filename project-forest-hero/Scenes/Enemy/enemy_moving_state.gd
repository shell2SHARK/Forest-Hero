extends State
class_name EnemyMovement

@onready var enemy : CharacterBody2D = get_parent().owner
var speedPatrol : float = 1.0
var direction : int = 1
var waitToCheck : bool = false

func enter():
	# Conecta o signal do area look 2d para entrar em idle to pursuit
	if not(enemy.lookArea.body_entered.is_connected(saw_player)):
		enemy.lookArea.body_entered.connect(saw_player)
	
	speedPatrol = enemy.enemyResource.speedPatrol
	get_initial_dir()

func physics_update(delta: float):
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
	# Ele flipa ao nao ter mais chao ou tocando em outro inimigo
	if(!enemy.raycastFloor.get_collider() is StaticBody2D or
		enemy.raycastVision.get_collider() and enemy.raycastVision.get_collider().is_in_group("Enemy")):
		# Se nao estiver mais tocando no chao, inverte o valor de direction para ir em outra direcao
		direction *= -1
		enemy.enemySpriteSheet.flip_h = direction < 0
		enemy.lookArea.get_child(0).rotation_degrees = 0 if direction > 0 else 180
		enemy.raycastVision.rotation_degrees = -90 if direction > 0 else 90
		waitToCheck = true
		await get_tree().create_timer(0.25).timeout
		waitToCheck = false

func saw_player(body: Node):
	if(body.is_in_group("Player")):
		changed_state.emit(self, "Idle_To_Pursuit")

func get_initial_dir():
	# Sorteia uma direcao e segue ela inicialmente
	direction = 1 if randf() > 0.5 else -1
	enemy.enemySpriteSheet.flip_h = direction < 0
	enemy.lookArea.get_child(0).rotation_degrees = 0 if direction > 0 else 180
	enemy.raycastVision.rotation_degrees = -90 if direction > 0 else 90
