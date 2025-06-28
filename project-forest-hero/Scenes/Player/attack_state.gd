extends State
class_name PlayerAttack

@onready var playerSpriteSheet := %AnimatedSprite2D # Coleta a folha de animacoes do player

func enter():
	if not playerSpriteSheet.animation_finished.is_connected(animation_end):
		playerSpriteSheet.animation_finished.connect(animation_end)
	attack()

func attack():
	playerSpriteSheet.play("Attack")

func animation_end():
	if(playerSpriteSheet.animation == "Attack"):
		changed_state.emit(self, "Movement")
