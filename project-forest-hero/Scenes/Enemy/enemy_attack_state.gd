extends State
class_name EnemyAttack

@onready var enemy : CharacterBody2D = get_parent().owner
var distanceToAttack := 1.0

func enter():
	connect_signals()
	play_sfx()
	enemy.enemySpriteSheet.play("Attack")

func physics_update(delta: float):
	enemy.gravity(delta)
	check_frames_to_hitbox()

func connect_signals():
	# Conecta o signal animation finished do sprite animation
	if not(enemy.enemySpriteSheet.animation_finished.is_connected(animation_end)):
		enemy.enemySpriteSheet.animation_finished.connect(animation_end)
	
	# Conecta o signal body enter do attack area
	if not(enemy.attack_area.body_entered.is_connected(deal_player_damage)):
		enemy.attack_area.body_entered.connect(deal_player_damage)

func check_frames_to_hitbox():
	# Se a animacao estiver no frame certo, ativa o colisor ou desabilita
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
		# Aplica o dano se for inimigo referente a arma que usa
		body.actualEnemy = enemy
		body.set_damage(enemy.enemyResource.axeValue)

func play_sfx():
	# Toca o sfx
	enemy.audioPlayer.stream = enemy.enemyResource.attackSFX
	enemy.audioPlayer.play()
