extends State
class_name EnemyDead

@onready var enemy : CharacterBody2D = get_parent().owner

func enter():
	enemy.enemySpriteSheet.play("Dead")
	enemy.collisionBox.set_deferred("disabled", true)
