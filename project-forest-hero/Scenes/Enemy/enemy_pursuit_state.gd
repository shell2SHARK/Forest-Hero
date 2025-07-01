extends State
class_name EnemyPursuit

@onready var enemy : CharacterBody2D = get_parent().owner
var speedPursuit := 1.0
var distanceToStop := 1.0
var direction := 1

func enter():
	set_pursuit()

func physics_update(delta: float):
	enemy.gravity(delta)
	pursuit()

func set_pursuit():
	enemy.alertIcon.visible = false # Desativa o alerta do inimigo
	enemy.lifeBar.visible = true
	speedPursuit = enemy.enemyResource.speedPursuit
	distanceToStop = enemy.enemyResource.distanceToAttack

func pursuit():
	# Segue o jogador
	direction = 1 if enemy.player.position.x > enemy.position.x else -1
	enemy.lookArea.get_child(0).rotation_degrees = 0 if direction > 0 else 180
	enemy.enemySpriteSheet.flip_h = enemy.player.position.x < enemy.position.x
	enemy.attack_area.rotation_degrees = 0 if direction > 0 else 180 # Compara quando a hitbox deve girar
	enemy.enemySpriteSheet.play("Walk")
	enemy.velocity.x = speedPursuit * direction
	enemy.move_and_slide()
	
	# Se chegar ate uma distancia perto do jogador,ataca
	var distanceToPlayer = enemy.global_position.distance_to(enemy.player.global_position)
	#print("seguindo = " , distanceToPlayer)
	if(distanceToPlayer <= distanceToStop):
		changed_state.emit(self, "Attack")
