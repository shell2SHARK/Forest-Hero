extends State
class_name EnemyIdleToPursuit

@onready var enemy : CharacterBody2D = get_parent().owner
var timeToWait := 1

func enter():
	timeToWait = enemy.enemyResource.timeToWaitUntilPursuit
	enemy.alertIcon.visible = true

func update(_delta: float):
	idle_to_go(timeToWait)

func idle_to_go(value):
	# Fica parado e olhado para o jogador ate dar tempo de segui-lo
	enemy.enemySpriteSheet.play("Idle")
	enemy.enemySpriteSheet.flip_h = enemy.player.position.x < enemy.position.x
	await get_tree().create_timer(value).timeout
	changed_state.emit(self, "Pursuit")
