extends State
class_name EnemyDead

@onready var enemy : CharacterBody2D = get_parent().owner

func enter():
	play_sfx()
	kill()

func kill():
	if(!enemy.deadByFall):
		enemy.enemySpriteSheet.play("Dead")
		enemy.collisionBox.set_deferred("disabled", true)
		enemy.attack_area.set_deferred("disabled", true)
		get_tree().get_first_node_in_group("PlayerUI").totalEnemies -= 1
		enemy.lifeBar.visible = false
		enemy.lookArea.get_child(0).visible = false
		await get_tree().create_timer(2).timeout
		var deadFx = enemy.enemyResource.deadEffect.instantiate()
		deadFx.position = enemy.position
		deadFx.enemyResource = enemy.enemyResource
		get_tree().current_scene.add_child(deadFx)
		enemy.queue_free()
	else:
		get_tree().get_first_node_in_group("PlayerUI").totalEnemies -= 1
		await get_tree().create_timer(1).timeout
		enemy.queue_free()

func play_sfx():
	enemy.audioPlayer.stream = enemy.enemyResource.deadSFX
	enemy.audioPlayer.play()
