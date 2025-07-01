extends State
class_name EnemyAttack

@onready var enemy : CharacterBody2D = get_parent().owner
var distanceToAttack := 1.0

func enter():
	# Conecta o signal animation finished do sprite animation
	if not(enemy.enemySpriteSheet.animation_finished.is_connected(animation_end)):
		enemy.enemySpriteSheet.animation_finished.connect(animation_end)
	
	if not(enemy.attack_area.body_entered.is_connected(deal_player_damage)):
		enemy.attack_area.body_entered.connect(deal_player_damage)
	
	enemy.enemySpriteSheet.play("Attack")

func update(_delta: float):
	# Se a animacao estiver no frame certo, ativa o colisor
	if(enemy.enemySpriteSheet.frame >= 3):
		enemy.attack_area.get_child(0).disabled = false
	if(enemy.enemySpriteSheet.frame >= 5):
		enemy.attack_area.get_child(0).disabled = true

func animation_end():
	# Se ataque acaba, e player nao esta mais perto. chama pursuit novamente
	if(enemy.enemySpriteSheet.animation == "Attack"):
		var distanceToPlayer = enemy.global_position.distance_to(enemy.player.global_position)
		if(distanceToPlayer > distanceToAttack):
			changed_state.emit(self, "Pursuit")
		else:
			enemy.enemySpriteSheet.play("Attack")

func deal_player_damage(body: Node):
	if(body.is_in_group("Player")):
		# Aplica o dano se for inimigo referente a arma do jogador
		body.actualEnemy = enemy
		body.set_damage(enemy.enemyResource.axeValue)
