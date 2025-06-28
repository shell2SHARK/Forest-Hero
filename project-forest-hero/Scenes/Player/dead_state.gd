extends State
class_name PlayerDead

@onready var player : CharacterBody2D = get_parent().owner

func enter():
	# Chama animacao de morte
	player.playerSpriteSheet.play("Dead")

func update(delta: float):
	# Zera os valores de movimento do jogador
	player.velocity.x = 0
	player.move_and_slide()
	
	if(Input.is_action_just_pressed("ui_accept")):
		get_tree().reload_current_scene()
