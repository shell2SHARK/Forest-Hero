extends State
class_name EnemyDead

@onready var enemy : CharacterBody2D = get_parent().owner

func enter():
	enemy.enemySpriteSheet.play("Dead")
	enemy.collisionBox.set_deferred("disabled", true)
	await get_tree().create_timer(2).timeout
	var deadFx = enemy.enemyResource.deadEffect.instantiate()
	deadFx.position = enemy.position
	deadFx.enemyResource = enemy.enemyResource
	get_tree().current_scene.add_child(deadFx)
	enemy.queue_free()
