extends State
class_name EnemyAttack

@onready var enemy : CharacterBody2D = get_parent().owner
var distanceToAttack := 1.0

func enter():
	# Conecta o signal animation finished do sprite animation
	if not(enemy.enemySpriteSheet.animation_finished.is_connected(animation_end)):
		enemy.enemySpriteSheet.animation_finished.connect(animation_end)
	
	enemy.enemyResource.distanceToAttack
	enemy.enemySpriteSheet.play("Attack")

func animation_end():
	# Se ataque acaba, e player nao esta mais perto. chama pursuit novamente
	if(enemy.enemySpriteSheet.animation == "Attack"):
		var distanceToPlayer = enemy.global_position.distance_to(enemy.player.global_position)
		if(distanceToPlayer > distanceToAttack):
			changed_state.emit(self, "Pursuit")
		else:
			enemy.enemySpriteSheet.play("Attack")
