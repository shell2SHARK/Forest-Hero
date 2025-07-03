extends CharacterBody2D

# Variaveis e nodes compartilhados
@onready var playerSpriteSheet := %AnimatedSprite2D # Coleta a folha de animacoes do player
@onready var attack_area := %Attack_Area
@onready var collisionBox : CollisionShape2D = %CollisionShape2D
@onready var audioPlayer : AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var life : float = playerResource.life
@onready var loseScene : PackedScene = preload("res://Scenes/UI/Win and Lose/Lose_UI.tscn")
@export var playerResource : PlayerData # Resource do jogador contendo sua data 
var actualEnemy : CharacterBody2D
var deadByAbyss := false

# Funcoes globais
func gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func set_damage(value: float):
	life -= value

	if(life <= 0):
		# Chama o estado de dead imediatamente
		$State_Machine.set_new_state($State_Machine.actualState, "Dead")
		
		# Para a musica principal
		var playerUI = get_tree().get_first_node_in_group("PlayerUI")
		playerUI.stop_music()
	else:
		# Chama o estado de knockback imediatamente
		$State_Machine.set_new_state($State_Machine.actualState, "Knockback")

func _on_get_area_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Heal")):
		# Se toca em um item de cura
		life += 1
		audioPlayer.stream = playerResource.healSFX
		audioPlayer.play()
		area.queue_free()
	elif(area.is_in_group("Killzone")):
		# Se toca no chao abaixo do cenario
		deadByAbyss = true
		var playerUI = get_tree().get_first_node_in_group("PlayerUI")
		playerUI.stop_music()
		playerUI.visible = false
		$State_Machine.set_new_state($State_Machine.actualState, "Dead")
		
		# Para cada inimigo, fazem eles voltarem a patrulhar normalmente
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			var stateMachineEnemy = enemy.get_node("State_Machine")
			stateMachineEnemy.set_new_state(stateMachineEnemy.actualState, "Movement")
