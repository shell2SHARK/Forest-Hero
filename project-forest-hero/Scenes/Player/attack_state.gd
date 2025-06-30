extends State
class_name PlayerAttack

@onready var player : CharacterBody2D = get_parent().owner

func enter():
	# Se ja houver um signal conectado de animation finished, nao chama mais apos trocar de state
	if not(player.playerSpriteSheet.animation_finished.is_connected(animation_end)):
		player.playerSpriteSheet.animation_finished.connect(animation_end)
	
	if not(player.attack_area.body_entered.is_connected(deal_enemy_damage)):
		player.attack_area.body_entered.connect(deal_enemy_damage)
		
	attack()

func update(delta: float):
	player.gravity(delta)
	# Se a animacao estiver no frame certo, ativa o colisor
	if(player.playerSpriteSheet.frame >= 3):
		player.attack_area.get_child(0).disabled = false

func attack():
	# Chama animacao de ataque
	player.playerSpriteSheet.play("Attack")

func deal_enemy_damage(body: Node):
	if(body.is_in_group("Enemy")):
		# Aplica o dano se for inimigo referente a arma do jogador
		body.set_damage(player.playerResource.swordValue)

func animation_end():
	# Acabando a animacao de ataque, volta a se mexer
	if(player.playerSpriteSheet.animation == "Attack"):
		changed_state.emit(self, "Movement")
		player.attack_area.get_child(0).disabled = true
