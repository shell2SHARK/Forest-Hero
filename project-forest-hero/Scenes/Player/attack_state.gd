extends State
class_name PlayerAttack

@onready var player : CharacterBody2D = get_parent().owner

func enter():
	# Se ja houver um signal conectado de animation finished, nao chama mais apos trocar de state
	if not player.playerSpriteSheet.animation_finished.is_connected(animation_end):
		player.playerSpriteSheet.animation_finished.connect(animation_end)
		
	attack()

func attack():
	# Chama animacao de ataque
	player.playerSpriteSheet.play("Attack")

func animation_end():
	# Acabando a animacao de ataque, volta a se mexer
	if(player.playerSpriteSheet.animation == "Attack"):
		changed_state.emit(self, "Movement")
