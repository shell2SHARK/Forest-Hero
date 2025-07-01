extends State
class_name EnemyDead

@onready var enemy : CharacterBody2D = get_parent().owner

func enter():
	kill()

func kill():
	enemy.enemySpriteSheet.play("Dead")
	enemy.collisionBox.set_deferred("disabled", true)
	enemy.attack_area.set_deferred("disabled", true)
	get_tree().get_first_node_in_group("PlayerUI").totalEnemies -= 1
	enemy.lifeBar.visible = false
	await get_tree().create_timer(2).timeout
	var deadFx = enemy.enemyResource.deadEffect.instantiate()
	deadFx.position = enemy.position
	deadFx.enemyResource = enemy.enemyResource
	get_tree().current_scene.add_child(deadFx)
	enemy.queue_free()
