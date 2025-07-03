extends State
class_name PlayerDead

@onready var player : CharacterBody2D = get_parent().owner

func enter():
	kill()

func physics_update(_delta: float):
	# Zera os valores de movimento do jogador
	player.velocity.x = 0
	player.move_and_slide()

func play_sfx():
	# Toca o sfx
	player.audioPlayer.stream = player.playerResource.deadSFX
	player.audioPlayer.play()

func kill():
	# Ativa animacao de morte e spawna tela de perdedor
	player.playerSpriteSheet.play("Dead")
	player.collisionBox.set_deferred("disabled", true)
	play_sfx()
	var loseScreen = player.loseScene.instantiate()
	add_child(loseScreen)
