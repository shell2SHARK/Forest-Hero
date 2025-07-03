extends State
class_name EnemyIdleToPursuit

@onready var enemy : CharacterBody2D = get_parent().owner
var timeToWait := 1

func enter():
	wake_to_player()
	play_sfx()

func update(_delta: float):
	idle_to_go(timeToWait)

func wake_to_player():
	# Seta os valores iniciais para comecar a perseguir
	timeToWait = enemy.enemyResource.timeToWaitUntilPursuit
	enemy.alertIcon.visible = true
	enemy.lookArea.get_child(0).visible = false

func idle_to_go(value):
	# Fica parado e olhado para o jogador ate dar tempo de segui-lo
	enemy.enemySpriteSheet.play("Idle")
	enemy.enemySpriteSheet.flip_h = enemy.player.position.x < enemy.position.x
	await get_tree().create_timer(value).timeout
	changed_state.emit(self, "Pursuit")

func play_sfx():
	# Toca o sfx
	enemy.audioPlayer.stream = enemy.enemyResource.alertSFX
	enemy.audioPlayer.play()
